# Running MRtrix3 in Colab

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/mrtrix3-in-colab/#post) [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/matteomancini/neurosnippets/blob/master/tips-and-tricks/mrtrix-in-colab/mrtrix_in_colab.ipynb)

This jupyter notebook shows how to install (just the first time) MRtrix3 on [Google Colab](https://colab.research.google.com/), keeping it on Google Drive, and how to use it for preprocessing purposes. As one may need to rapidly peek at the data or use directly the terminal, it also shows how to access a Colab instance through SSH. More details available in this [post](http://neurosnippets.com/posts/mrtrix3-in-colab/#post).

Some things to keep in mind:
* a compiled version of MRtrix3 can be downloaded from [this link](https://drive.google.com/file/d/1AppHBa9cPz2dQsIX8-Ca8r15KGasluFn/view?usp=sharing);
* if one wants to install [ANTs](http://stnava.github.io/ANTs/), there is [this post](https://www.suyogjadhav.com/misc/2019/03/28/Using-ANTs-package-on-Google-Colaboratory/) by [Suyog Jadhav](https://github.com/IAmSuyogJadhav) that explains how to do it and provides an already compiled version;
* if one wants to install [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/), there are three ways:
    - using [NeuroDebian](https://neuro.debian.net) - this is the fastest way, but has the drawback that so far the most updated version would be FSL 5:

    ```
    # from inside a notebook
    !apt-get update
    !apt-get install neurodebian-archive-keyring
    !add-apt-repository "deb http://neuro.debian.net/debian bionic main contrib non-free"
    !apt-get install fsl-core
    ```

    - installation through the `fslinstaller.py` script - this allows to install a very recent version of FSL, but it can take quite some time, and the disk space required is quite large:
    
    
    ```
    !apt-get install file # required
    !wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
    !python2 fslinstaller.py
    ```

    - downloading a precompiled version - this is slightly faster than using the script, but it still requires a large amount of disk space:
    ```
    !wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.4-centos6_64.tar.gz
    !tar xvzf fsl-6.0.4-centos6_64.tar.gz
    ```
