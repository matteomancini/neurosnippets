#!/bin/bash
# Script to preprocess diffusion MRI data using papermill
# Example data: MASiVar dataset - https://openneuro.org/datasets/ds003416/versions/1.0.0
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 17/02/2021

# Retrieving data through datalad
datalad install https://github.com/OpenNeuroDatasets/ds003416.git
datalad get -J 4 ds003416/sub-cIIIsA01/ses-s1Bx1/*

# Copying data and launching papermill
mkdir sample_data
cp ds003416/sub-cIIIsA01/ses-s1Bx1/dwi/*104* sample_data/
cp ds003416/sub-cIIIsA01/ses-s1Bx1/dwi/*105* sample_data/
mkdir results
cd results
papermill ../dwi_preproc.ipynb \
    -p ap ../sample_data/sub-cIIIsA01_ses-s1Bx1_acq-b1000n3r21x21x22peAPA_run-104_dwi.nii.gz \
    -p pa ../sample_data/sub-cIIIsA01_ses-s1Bx1_acq-b1000n40r21x21x22peAPP_run-105_dwi.nii.gz \
    -p ap_b0 3 results.ipynb
jupyter nbconvert results.ipynb --no-input --to html
