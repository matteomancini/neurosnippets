# Making a glass brain

This bash script generates a glass brain from diffusion MRI data as described in this [post](http://neurosnippets.com/posts/glass-brain/#post).

To run it, you need the following tools:
* git-annex (7.20190819);
* datalad (0.11.8);
* MRtrix3 (3.0-RC3);
* FSL (6.0);
* TractSeg (2.2).

The script was tested on Ubuntu 18.04.

Some things to keep in mind:
* the script foreach provided in MRtrix3 has been renamed to for_each in more recent versions to [avoid conflicts with zsh in macOS](https://github.com/MRtrix3/mrtrix3/issues/1708) - if you are using the most up-to-date version, please update the script accordingly;
* the script dwipreproc used to run eddy in MRtrix3 has been renamed to dwifslpreproc in more recent versions - if you are using the most up-to-date version, please update the script accordingly;
* a counter-intuitive fun fact: to align the tractography in subject space with the template, the script [uses the inverse warp (from template to subject)](https://community.mrtrix.org/t/warping-tck-files-using-ants-warps/162/4).