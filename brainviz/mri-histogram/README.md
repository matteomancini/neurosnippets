# A dashboard to quickly check MRI data

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/mri-histogram/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/) [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/matteomancini/neurosnippets/blob/master/brainviz/mri-histogram/mri-histogram.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/matteomancini/neurosnippets/master?filepath=brainviz/mri-histogram/mri-histogram.ipynb)

This dashboard makes easy to navigate an MRI volume and to get as an histogram the distribution of its values in a given area. It is just a matter of drawing a path on top of the image. It is realised using [Dash](https://dash.plotly.com/introduction 'Dash Documentation'). More details available in this [post](http://neurosnippets.com/posts/mri-histogram/#post).

To run the dashboard using `mri-histogram.py`, you need `python` (`3.7`) and the following packages:
* `plotly` (`4.14.3`);
* `dash` (`1.19.0`);
* `dash-core-components` (`1.15.0`);
* `dash-html-components` (`1.1.2`);
* `nibabel` (`3.0.0`);
* `numpy` (`1.18.4`);
* `scipy` (`1.4.1`);
* `scikit-image` (`0.18.1`).

To run the dashboard using `mri-histogram.ipynb`, you will also need `jupyter-dash` (`0.4.0`).

The code was tested on macOS `10.15.7`.

Some things to keep in mind:
* as the final mask to compute the histogram is fitted through the `draw.polygon()` method from `scikit-image`, it is not necessary to draw a _perfectly_ closed path;
* Dash now offers an even more powerful way to handle directly tridimensional data: [`dash-slicer`](https://dash.plotly.com/slicer 'Dash Documentation').
