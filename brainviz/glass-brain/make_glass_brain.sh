#!/bin/bash

# Retrieving the data using DataLad
datalad install https://github.com/OpenNeuroDatasets/ds001378
cd ds001378
datalad get -J 4 sub-control*/ses-01/dwi/*

# Pre-processing using MRtrix3
for sub in $(ls -d sub-control*); do
    mrconvert -fslgrad $sub/ses-01/dwi/${sub}_ses-01_dwi.bvec \
        $sub/ses-01/dwi/${sub}_ses-01_dwi.bval $sub/ses-01/dwi/${sub}_ses-01_dwi.nii.gz \
        $sub/ses-01/dwi/${sub}_ses-01_dwi.mif
    dwidenoise $sub/ses-01/dwi/${sub}_ses-01_dwi.mif \
        $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-denoised.mif
    mrdegibbs $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-denoised.mif \
        $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-unringed.mif
    dwipreproc $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-unringed.mif \
        $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-preproc.mif -rpe_none -pe_dir PA

    dwiextract -bzero $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-preproc.mif - | \
        mrmath - mean $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-meanb0.mif -axis 3
    dwi2mask $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-preproc.mif \
        $sub/ses-01/dwi/${sub}_ses-01_dwi_desc-mask.mif
done

# Building a template with MRtrix3
mkdir -p ../template/meanb0s
mkdir ../template/masks
foreach sub-control* : ln -sr IN/ses-01/dwi/NAME_ses-01_dwi_desc-meanb0.mif \
    ../template/meanb0s/NAME.mif
foreach sub-control* : ln -sr IN/ses-01/dwi/NAME_ses-01_dwi_desc-mask.mif \
    ../template/masks/NAME.mif

population_template ../template/meanb0s -mask_dir ../template/masks \
    ../template/meanb0_template.mif

foreach sub-control* : mrregister IN/ses-01/dwi/NAME_ses-01_dwi_desc-meanb0.mif \
    -mask1 IN/ses-01/dwi/NAME_ses-01_dwi_desc-mask.mif ../template/meanb0_template.mif \
    -nl_warp IN/ses-01/dwi/NAME_ses-01_dwi_desc-warp_sub2tmp.mif \
    IN/ses-01/dwi/NAME_ses-01_dwi_desc-warp_tmp2sub.mif

mkdir -p ../template/masks_tmp
foreach sub-control* : mrtransform IN/ses-01/dwi/NAME_ses-01_dwi_desc-mask.mif \
    -warp IN/ses-01/dwi/NAME_ses-01_dwi_desc-warp_sub2tmp.mif -inter nearest \
    -datatype bit ../template/masks_tmp/IN.mif
cd ../template

# Making a glass brain!
mrmath masks_tmp/* mean mask_mean.mif
mrresize mask_mean.mif -scale 5 mask_up.mif
mrfilter mask_up.mif smooth -stdev 2 mask_smooth.mif
mrthreshold mask_smooth.mif -abs 0.5 mask_thres.mif
maskfilter mask_thres.mif dilate -npass 2 mask_dilated.mif
mrcalc mask_dilated.mif mask_thres.mif -subtract glass_brain.mif

# Reconstructing the Corpus Callosum with TractSeg
cd ../ds001378/sub-control01/ses-01/dwi
dwi2response tournier sub-control01_ses-01_dwi_desc-preproc.mif \
    sub-control01_ses-01_dwi_desc-response.txt
dwiextract sub-control01_ses-01_dwi_desc-preproc.mif - | dwi2fod msmt_csd - \
    sub-control01_ses-01_dwi_desc-response.txt \
    sub-control01_ses-01_dwi_desc-wmfod.mif \
    -mask sub-control01_ses-01_dwi_desc-mask.mif
sh2peaks sub-control01_ses-01_dwi_desc-wmfod.mif \
    sub-control01_ses-01_dwi_desc-peaks.nii.gz
TractSeg -i sub-control01_ses-01_dwi_desc-peaks.nii.gz
TractSeg -i sub-control01_ses-01_dwi_desc-peaks.nii.gz --output_type TOM
tckgen -algorithm FACT -angle 20 -seed_image sub-control01_ses-01_dwi_desc-mask.mif \
    tractseg_output/TOM/CC.nii.gz sub-control01_ses-01_dwi_desc-CC.tck
tcktransform sub-control01_ses-01_dwi_desc-CC.tck \
    sub-control01_ses-01_dwi_desc-warp_tmp2sub.mif ../../../../template/CC.tck
