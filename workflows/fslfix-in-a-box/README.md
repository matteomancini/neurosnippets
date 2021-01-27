# FSL-FIX in a box

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/fslfix-in-a-box/#post) [![dockerhub](https://img.shields.io/badge/dockerhub-ingmatman-blue)](https://hub.docker.com/repository/docker/ingmatman/fslfix/general)

This `Dockerfile` creates a container based on Ubuntu, with both [`FSL`](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/ 'FSL website') and [`FIX`](https://git.fmrib.ox.ac.uk/fsl/fix 'FIX Gitlab') installed. The related `bash` script shows how to use it to preprocess fMRI data.  More details available in this [post](http://neurosnippets.com/posts/fslfix-in-a-box/#post).

To run the script, you need the following tools:
* `docker` (`20.10.0`);
* `git-annex` (`7.20190819`);
* `datalad` (`0.11.8`).

The script was tested on Ubuntu `18.04`.

Some things to keep in mind:
* the `Dockerfile` does not specify an entry point -- this is on purpose, because one can use the container to run any of the FSL tools;
* in Linux, running some of the GUI tools (e.g. `Melodic`) requires only to mount the `.Xauthority` file from the host on the container (as done in the `bash` script; in macOS and in Windows, you actually need to install an X server -- more details are available in [this post](https://cuneyt.aliustaoglu.biz/en/running-gui-applications-in-docker-on-windows-linux-mac-hosts/ 'Running GUI applications in Docker on Windows, Linux and Mac hosts').