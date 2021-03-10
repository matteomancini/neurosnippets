#!/bin/bash
# Full processing to generate bundle-wise, myelin-weighted connectome
# Example data: MICRA dataset - https://osf.io/z3mkn/
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 10/03/2021

# Retrieve data from the MICRA dataset from OSF
# Downloading anatomical, diffusion and MWF data for subject 1 and session 1
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/anat/sub-01_ses-01_T1w.nii.gz
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/dwi/sub-01_ses-01_part-mag_dwi.nii.gz
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/dwi/sub-01_ses-01_part-mag_dwi.bvec
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/dwi/sub-01_ses-01_part-mag_dwi.bval
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/fmap/sub-01_ses-01_part-mag_epi.nii.gz
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/fmap/sub-01_ses-01_part-mag_epi.bvec
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/sub-01/ses-01/fmap/sub-01_ses-01_part-mag_epi.bval
wget https://files.osf.io/v1/resources/z3mkn/providers/owncloud/derivatives/sub-01/ses-01/McDespot/MWF1.nii.gz

# Clone FastSurfer repo, install requirments and run FastSurfer
git clone git clone https://github.com/Deep-MI/FastSurfer.git
pip3 install -r FastSurfer/requirements.txt
mkdir fastsurfer_subjects
./FastSurfer/run_fastsurfer.sh --t1 sub-01_ses-01_T1w.nii.gz --sid sub1 --sd fastsurfer_subjects --parallel --threads 4

# Run diffusion pre-processing (using a tailor notebook and papermill)
mkdir dwpreproc
cd dwpreproc
papermill ../../papermill-preproc/dwi_preproc.ipynb -p ap ../sub-01_ses-01_part-mag_dwi.nii.gz \
    -p pa sub-01_ses-01_part-mag_epi.nii.gz -p main_dir "AP" results.ipynb
cd ..

# Run actual processing
mkdir processing
cd processing
../build_bundle_connectome.sh ../dwpreproc/eddy_corrected.nii.gz ../dwpreproc/eddy_corrected.eddy_rotated_bvecs \
    ../sub-01_ses-01_part-mag_dwi.bval ../fastsurfer_subjects sub1 ../MWF1.nii.gz ../
