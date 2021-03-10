# A recipe for bundle-wise, myelin-weighted connectomes

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/bundle-connectome/#post) [![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

The scripts `build_bundle_connectome.sh` and `bundle_connectome.sh` allow to quickly reconstructing a structural connectome from  diffusion MRI data but weighted using a different map (in this example, a myelin map) in a bundle-wise fashion. An additional script (`run.sh`) shows how to use it on the [MICRA](https://osf.io/z3mkn/ 'MICRA on OSF') dataset.  More details available in this [post](http://neurosnippets.com/posts/bundle-connectome/#post).

To run the overall script on the example data, you need the following packages:
* `mrtrix` (`3.0.0`);
* `fsl` (`6.0`);
* `freesurfer` (`6.0.0`);
* `papermill` (`2.3.2`);
* `notebook` (`6.1.5`);
* `nibabel` (`3.2.1`);
* `matplotlib` (`3.3.4`);
* `numpy` (`1.18.4`);
* `fastsurfer` (`run.sh` takes already care of installing it).

The script was tested on Ubuntu `18.04`.

Some things to keep in mind:
* for diffusion MRI pre-processing, `run.sh` uses [`papermill`](../papermill-preproc);
* `build_bundle_connectome.sh` assumes that the map of interested (in this example, [a myelin water fraction map estimated from MCDESPOT](https://www.sciencedirect.com/science/article/pii/S1053811920308910 'Koller et al. 2021')) can be linearly registered to the anatomical reference; if it is not the case, please consider to replace the linear registration using [ANTs](https://github.com/ANTsX/ANTs 'Advanced Normalization Tools');
* if you are using the output from FreeSurfer (rather than FastSurfer), you may want to edit the script in order to use `aparc+aseg.mgz` instead of `aparc+aseg.orig.mgz`.
