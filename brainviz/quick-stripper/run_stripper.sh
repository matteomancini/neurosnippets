#!/bin/bash
# Script to run streamlit for quick BET-based skull-stripping 
# Example data: Deep Image Reconstruction - https://openneuro.org/datasets/ds001506/versions/1.3.1
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 23/02/2021

datalad install https://github.com/OpenNeuroDatasets/ds001506.git
datalad get -J 4 ds001506/sub-01/ses-anatomy/anat/sub-01_ses-anatomy_T1w.nii.gz 
fslreorient2std ds001506/sub-01/ses-anatomy/anat/sub-01_ses-anatomy_T1w.nii.gz T1w_reoriented.nii.gz
streamlit run quick_stripper.py 
