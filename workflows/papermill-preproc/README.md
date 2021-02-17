# Diffusion MRI preprocessing through papermill

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/papermill-preproc/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

The `dwi_preproc.ipynb` notebook offers a powerful way to do diffusion MRI preprocessing running the notebook itself as a script through [`papermill`](https://papermill.readthedocs.io/en/latest/ 'Papermill documentation'): after each preprocessing step performed with [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/ 'FSL website') and [MRtrix](https://mrtrix.readthedocs.io/en/latest/ 'MRtrix documentation'), the notebook also displays the intermediate data, making it easier to double-check the outcome and troubleshoot potential issues. The related `bash` script shows how to use it on the [MASiVar](https://openneuro.org/datasets/ds003416/versions/1.0.0 'MASiVar on OpenNeuro') dataset.  More details available in this [post](http://neurosnippets.com/posts/papermill-preproc/#post).

To run the script, you need the following packages:
* `git-annex` (`7.20190819`);
* `datalad` (`0.11.8`);
* `mrtrix` (`3.0.0`);
* `fsl` (`6.0`);
* `papermill` (`2.3.2`);
* `notebook` (`6.1.5`);
* `nibabel` (`3.2.1`);
* `matplotlib` (`3.3.4`).

The script was tested on Ubuntu `18.04` and on macOS `10.15.7`.

Some things to keep in mind:
* if you haven't run `black` (one of the dependencies for `papermill`) before, you may see some error due to the cache folder not existing yet; it shouldn't affect the process, but to get rid of it, one can just run `black` on a sample script and solve the issue - more details are provided [here](https://github.com/psf/black/pull/1539);
* for the moment, there is a tentative `Dockerfile`, but when running the container it gives a `segmentation fault` error as it starts running `topup`; this may be an issue of FSL 5 (which is the version available on NeuroDebian). Installing FSL 6 could solve the issue but would make the container image very large - if you have suggestions/ideas/solutions please get in touch!