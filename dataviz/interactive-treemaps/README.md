# Interactive treemaps for interactive reviews

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/interactive-treemaps/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/) [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/matteomancini/neurosnippets/blob/master/dataviz/interactive-treemaps/treemap.ipynb) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/matteomancini/neurosnippets/master?filepath=dataviz/interactive-treemaps/treemap.ipynb)

This jupyter notebook generates a treemap from a spreadsheet of data, similar to the ones included in scientific reviews and meta-analyses. For this example, the spreadsheet `dataset.xlsx` contains part of the data collected in [this paper by Straathof and colleagues](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6360487/). More details available in this [post](http://neurosnippets.com/posts/interactive-treemaps/#post).

To run it, you need `python` (`3.7`) and the following packages:
* `pandas` (`0.25.3`);
* `plotly` (`4.8.1`).

The script was tested on macOS `10.15.7`.

Some things to keep in mind:
* a more extensive example of this use of treemaps can be found [here](https://github.com/matteomancini/myelin-meta-analysis);
* the function `build_hierarchical_dataframe` extends the one presented in the [`plotly` documentation](https://plotly.com/python/treemaps/#treemap-chart-with-a-continuous-colorscale) to handle leaves with the same name but in different branches of the treemap;
* in `plotly.express`, same-name leaves are automatically handled using the internal functions [`build_dataframe`](https://github.com/plotly/plotly.py/blob/03979d105c65dda3df3a155322eaff18f203b03f/packages/python/plotly/plotly/express/_core.py#L1254) and [`process_args_into_dataframe`](https://github.com/plotly/plotly.py/blob/03979d105c65dda3df3a155322eaff18f203b03f/packages/python/plotly/plotly/express/_core.py#L1052).
