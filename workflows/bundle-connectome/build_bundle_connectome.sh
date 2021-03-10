#!/bin/bash
# Script to reconstruct bundle-wise, myelin-weighted connectome
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 10/03/2021

usage() {
	echo "Usage: $0 dwi bvec bval fs_folder fs_subject map [script_path]"
}

if [ $# -le 5 ]; then
	usage
	exit 0
fi

dwi=$1 # diffusion data
bvec=$2 # bvec
bval=$3 # bval
sub_folder=$4 # FastSurfer subjects folder
fs=$5 # FastSurfer subject name
mymap=$6 # Myelin map (or other custom map)
script_path='.'
if [ $# -eq 7 ]; then
    script_path=$7 # script path (i.e. where is bundle_connectome.py)
fi

# converting data to MIF
mrconvert -fslgrad $bvec $bval $dwi dwi.mif
dwibiascorrect ants dwi.mif dwi_unbiased.mif
dwi2mask dwi_unbiased.mif mask.nii.gz

# computing a masked meanb0
dwiextract -bzero dwi.mif b0_vols.nii
mrmath b0_vols.nii mean meanb0.nii -axis 3
mrcalc meanb0.nii mask.nii.gz -mult b0_masked.nii

# registration
mri_convert --in_type mgz --out_type nii --out_orientation RAS ${sub_folder}/$fs/mri/brain.mgz brain.nii
mrconvert ${sub_folder}/$fs/mri/aparc+aseg.orig.mgz aparc+aseg.nii
fast -v brain.nii
flirt -in $mymap -ref brain.nii -dof 6 -out mymap_anat.nii.gz
flirt -in b0_masked.nii -ref brain.nii -dof 6 -omat dw2anat_init.mat
flirt -in b0_masked.nii -ref brain.nii -cost bbr -wmseg brain_pve_2.nii.gz -init dw2anat_init.mat -omat dw2anat.mat \
    -dof 6 -schedule ${FSL_DIR}/etc/flirtsch/bbr.sch
transformconvert dw2anat.mat meanb0.nii brain.nii flirt_import dw2anat_mrtrix.txt
mrtransform -linear dw2anat_mrtrix.txt -inverse mymap_anat.nii.gz mymap_dw.mif
mrtransform -linear dw2anat_mrtrix.txt -inverse brain.nii brain_dw.mif
mrtransform -linear dw2anat_mrtrix.txt -inverse -interp nearest -template brain.nii aparc+aseg.nii aparc+aseg_dw.mif
labelconvert aparc+aseg_dw.mif ${FREESURFER_HOME}/FreeSurferColorLUT.txt ${script_path}/fs_85nodes.txt nodes.nii

# generating 5tt file, FOD and tracking
5ttgen fsl -nocrop -premasked brain_dw.mif 5tt.mif
dwi2response msmt_5tt dwi.mif 5tt.mif wm.txt gm.txt csf.txt
dwi2fod msmt_csd dwi.mif wm.txt wm.mif gm.txt gm.mif csf.txt csf.mif -mask mask.nii.gz
tckgen wm.mif track1M.tck -act 5tt.mif -backtrack -crop_at_gmwmi -seed_dynamic wm.mif -minlength 10 -maxlength 250 -angle 30 -select 1M
tcksample track1M.tck mymap_dw.mif mymap.csv

# generating connectome
tck2connectome -symmetric -zero_diagonal -out_assignments fibers_assignment.txt track1M.tck nodes.nii connectome.csv
# removing comments from csv and txt files
sed -i '/^#/d' mymap.csv
sed -i '/^#/d' fibers_assignment.txt
# generating map-bundle-weighted connectome
${script_path}/bundle_connectome.py fibers_assignment.txt mymap.csv --mean connectome_mymap.csv
