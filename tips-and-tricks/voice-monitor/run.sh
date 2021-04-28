#!/bin/bash
# Short script to retrieve some data with dipy and process them through MRtrix3
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under the MIT license
# Last revised: 25/01/2021

echo "Downloading data"
python -c "from dipy.data import fetch_sherbrooke_3shell;fetch_sherbrooke_3shell()"

echo "Converting files"
mrconvert -fslgrad .dipy/sherbrooke_3shell/HARDI193.bvec \
    .dipy/sherbrooke_3shell/HARDI193.bval .dipy/sherbrooke_3shell/HARDI193.nii.gz \
    dwi.mif

echo "Creating a mask"
dwi2mask dwi.mif mask.mif

echo "Estimating response function"
dwi2response dhollander dwi.mif wm.txt gm.txt csf.txt

echo "Reconstructing fiber orientation distribution"
dwi2fod -mask mask.mif msmt_csd dwi.mif wm.txt wm.mif \
    gm.txt gm.mif csf.txt csf.mif

echo "Tracking"
tckgen -select 100000 -seed_image mask.mif wm.mif track.tck

echo "Done!"
