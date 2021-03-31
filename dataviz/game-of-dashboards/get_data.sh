#!/bin/bash

datalad install https://github.com/OpenNeuroDatasets/ds000243.git
cd ds000243/
datalad get sub-001/func/sub-001_task-rest_run-1_bold.nii.gz
cp sub-001/func/sub-001_task-rest_run-1_bold.nii.gz ../bold.nii.gz
