#!/bin/bash
# Script to retrieve data and convert files for interactive network plots
# Example data: USC Multimodal Connectivity Database - http://umcd.humanconnectomeproject.org/umcd/default/update/8
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 03/03/2021

# Retrieving data
curl http://umcd.humanconnectomeproject.org/umcd/default/download/upload_data.region_names_full_file.bc632972b9a48788.667265657375726665725f726567696f6e735f36385f736f72745f66756c6c2e747874.txt --output freesurfer_regions_68_sort_full.txt
curl http://umcd.humanconnectomeproject.org/umcd/default/download/upload_data.region_xyz_centers_file.b9cd458ce4fd4eb8.66735f726567696f6e5f63656e746572735f36385f736f72742e747874.txt --output fs_region_centers_68_sort.txt
curl http://umcd.humanconnectomeproject.org/umcd/default/download/upload_data.connectivity_matrix_file.a163727c41ff21ca.6963626d5f66696265725f6d61742e747874.txt --output icbm_fiber_mat.txt

# Converting brain surface from BERT first in ASCII and then in .obj
# NB: it requires FreeSurfer!
mris_convert $SUBJECTS_DIR/bert/surf/lh.pial lh.pial.asc
./srf2obj lh.pial.asc > lh.pial.obj
