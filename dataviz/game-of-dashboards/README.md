# One brain, one dashboard, four frameworks

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/game-of-dashboards/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

Using four different frameworks, a dashboard for plotting BOLD timecourses from functional MRI data is implemented. It is realised using [Streamlit](https://www.streamlit.io 'Streamlit'), [Dash](https://dash.plotly.com/introduction 'Dash Documentation'), [Bokeh](https://bokeh.org 'Bokeh') and [HoloViz](https://holoviz.org 'Holoviz'). More details available in these posts: [part 1](http://neurosnippets.com/posts/game-of-dashboards/#post) and [part 2](http://neurosnippets.com/posts/game-of-dashboards-2/#post).

To run the dashboards, you need `python` (`3.7`) and the following packages:
* `streamlit` (`0.79.0`);
* `plotly` (`4.14.3`);
* `dash` (`1.19.0`);
* `dash-core-components` (`1.15.0`);
* `dash-html-components` (`1.1.2`);
* `matplotlib` (`3.1.2`);
* `nibabel` (`3.0.0`);
* `numpy` (`1.18.4`);
* `panel` (`0.11.2`);
* `bokeh` (`2.3.0`).

The code was tested on macOS `10.15.7`.

Some things to keep in mind:
* in the HoloViz implementation, the first plotting function uses the image object defined later in the code - the ideal solution would be to pass the reference as a parameter to the function, but it leads to [an error when called through `panel.interact`](https://stackoverflow.com/questions/24046558/pass-data-array-to-interact-function). If you have solution, please get in touch!