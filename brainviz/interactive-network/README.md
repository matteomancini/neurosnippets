# Interactive brain networks

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/interactive-network/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/) [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/matteomancini/neurosnippets/blob/master/brainviz/interactive-network/interactive_network.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/matteomancini/neurosnippets/master?filepath=brainviz/interactive-network/interactive_network.ipynb)

This jupyter notebook generates an interactive brain network graph starting from a connectivity matrix and the related nodes coordinates using [`plotly`](https://plotly.com 'Plotly homepage'). The example data used here are available on the [USC Multimodal Connectivity Database](http://umcd.humanconnectomeproject.org/umcd/default/update/8 'UMCD'). More details available in this [post](http://neurosnippets.com/posts/interactive-network/#post).

To run it, you need `python` (`3.7`) and the following packages:
* `numpy` (`1.18.4`);
* `plotly` (`4.14.3`).
To regenerate the brain surface file, `freesurfer` (`6.0.0`) is required.
The script was tested on macOS `10.15.7`.

Some things to keep in mind:
* The script `srf2obj` is available on [Brainder](https://brainder.org/2012/05/08/importing-freesurfer-cortical-meshes-into-blender/ 'brainder.org');
* For visualization purposes, only the left half of the brain surface is visualized on top of the graph - despite being qualitatively aligned, one needs to take in mind that the nodes' coordinates and the surface have not been registered;
* More detailed examples on 3D plotting with [`plotly`](https://plotly.com 'Plotly homepage') are available [here](https://plotly.com/python/v3/3d-network-graph/ '3D network graph') and [here](https://plotly.com/python/3d-mesh/#mesh-tetrahedron '3D meshes');
* To display the brain surface, the `lh.pial` file from the FreeSurfer `surf` folder is first converted to ASCII, then to `.obj` format and finally is rearranged with a tailored function (as described [here](https://chart-studio.plotly.com/~empet/15040/plotly-mesh3d-from-a-wavefront-obj-f/#/)); if you have a more direct way to do this, please get in touch!
