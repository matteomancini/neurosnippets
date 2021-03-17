# A minimal Streamlit-based viewer for DICOM data

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/diesitcom/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

This dashboard offers a painless way to quick access both images and metadata from DICOM data. It is realised using [ITK](https://simpleitk.readthedocs.io/en/master/ 'SimpleITK Documentation') and [streamlit](https://www.streamlit.io 'Streamlit'). More details available in this [post](http://neurosnippets.com/posts/diesitcom/#post).

To run the dashboard using the script `run_diesitcom.sh`, you need `python` (`3.7`) and the following packages:

* `streamlit` (`0.76.0`);
* `matplotlib` (`3.1.2`);
* `pandas` (`0.25.3`);
* `SimpleITK` (`2.0.2`).

To directly download the sample data folder from the [dash-vtk repository](https://github.com/plotly/dash-vtk 'Dash-VTK') you also need `svn` (`1.14.0`). Alternatively, you can just clone the whole repository.

The code was tested on macOS `10.15.7`.

Some things to keep in mind:
* the dashboard assumes that the DICOM folders containg the data are in the current folder;
* with some tricks, Streamlit can be run on Colab (an example is [here](https://github.com/mrm8488/shared_colab_notebooks/blob/master/Create_streamlit_app.ipynb 'Running Streamlit on Colab')) and on Binder (as done [here](https://github.com/chekos/testing-streamlit-mybinder 'Running Streamlit on Binder')).
