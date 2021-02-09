#!/bin/bash

# Downloading the data from https://github.com/JosePMarques/MP2RAGE-related-scripts
wget https://github.com/JosePMarques/MP2RAGE-related-scripts/raw/master/data/T1corrected.nii

# Cropping and reorienting the volume
fslroi T1corrected.nii T1map_cropped.nii.gz 20 170 60 130 12 123
fslreorient2std T1map_cropped.nii.gz T1map_cropped_reoriented.nii.gz
