#!/bin/bash
# Script to run streamlit for quickly opening DICOM data
# Example data: dash-vtk - https://github.com/plotly/dash-vtk
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 17/03/2021

svn checkout https://github.com/plotly/dash-vtk/trunk/demos/data/mri_brain
streamlit run diesitcom.py
