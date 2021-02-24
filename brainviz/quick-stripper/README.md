# Quick visual skull-stripping with FSL BET and Streamlit

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/quick-stripper/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

This dashboard allows to quickly try different thresholds for skull-stripping with [FSL BET](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET/UserGuide 'BET User Guide'). It is realised using [streamlit](https://www.streamlit.io 'Streamlit'). More details available in this [post](http://neurosnippets.com/posts/quick-stripper/#post).

To run the dashboard using the script `run_stripper.sh`, you need `python` (`3.7`) and the following packages:
* `fsl` (`6.0`);
* `streamlit` (`0.76.0`);
* `matplotlib` (`3.1.2`);
* `nibabel` (`3.0.0`);
* `numpy` (`1.18.4`).

The code was tested on macOS `10.15.7`.

Some things to keep in mind:
* the dashboard assumes that the images to skull-strip (in `nii` or `gz` format) are in the current folder;
* with some tricks, Streamlit can be run on Colab (an example is [here](https://github.com/mrm8488/shared_colab_notebooks/blob/master/Create_streamlit_app.ipynb 'Running Streamlit on Colab')) and on Binder (as done [here](https://github.com/chekos/testing-streamlit-mybinder 'Running Streamlit on Binder')).
