#!/bin/bash
# Script to preprocess fMRI resting state data using the ingmatman/fslfix container
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under the MIT license
# Last revised: 25/01/2021

cd $HOME
# docker build -t ingmatman/fslfix .
docker pull ingmatman/fslfix

datalad install https://github.com/OpenNeuroDatasets/ds000224.git

datalad get -J 4 ds000224/sub-MSC01/ses-*01/

mkdir fixdata

cp ds000224/sub-MSC01/ses-func01/func/sub-MSC01_ses-func01_task-rest_bold.nii.gz fixdata/sub01_func_rs.nii.gz

cp ds000224/sub-MSC01/ses-struct01/anat/sub-MSC01_ses-struct01_run-01_T1w.nii.gz fixdata/sub01_anat_t1w.gz

# docker run --net="host" --env="DISPLAY" -v="$HOME/.Xauthority:/home/fsluser/.Xauthority:rw" \
#     -v="$HOME/fixdata:/home/fsluser/data:rw" ingmatman/fslfix bash -c "Melodic"
cp design.fsf fixdata/ 
docker run --net="host" --env="DISPLAY" -v="$HOME/.Xauthority:/home/fsluser/.Xauthority:rw" \
    -v="$HOME/fixdata:/home/fsluser/data:rw" ingmatman/fslfix bash -c "melodic data/design.fsf"

docker run --net="host" --env="DISPLAY" -v="$HOME/.Xauthority:/home/fsluser/.Xauthority:rw" \
    -v="$HOME/fixdata:/home/fsluser/data:rw" ingmatman/fslfix bash -c "fix data/results.ica /opt/fix/training_files/Standard.RData 20"
