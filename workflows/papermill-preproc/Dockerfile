FROM neurodebian:buster-non-free

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
           apt-utils \
           bzip2 \
           ca-certificates \
           curl \
           locales \
           unzip \
           wget \
           python3 \
           python3-pip \
           python3-setuptools \
    && pip3 install wheel && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# MRtrix 3.0.0
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    g++ python python-numpy libeigen3-dev zlib1g-dev libqt4-opengl-dev \
    libgl1-mesa-dev libfftw3-dev libtiff5-dev graphviz \
    && wget https://github.com/MRtrix3/mrtrix3/archive/3.0.0.zip \
    && unzip 3.0.0.zip && cd mrtrix3-3.0.0 && ./configure -nogui \
    && ./build && cd .. && mv mrtrix3-3.0.0 /usr/share/mrtrix3 \
    && apt-get purge -y g++ python python-numpy && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && rm -rf 3.0.0.zip

ENV PATH="/usr/share/mrtrix3/bin:${PATH}"

# FSL 5.0
RUN apt-get update && apt-get install -y fsl-core && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV FSLDIR=/usr/share/fsl/5.0
ENV FSL_DIR="${FSLDIR}"
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV PATH=/usr/lib/fsl/5.0:$PATH
ENV FSLMULTIFILEQUIT=TRUE
ENV POSSUMDIR=/usr/share/fsl/5.0
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish
ENV FSLOUTPUTTYPE=NIFTI_GZ

# nibabel, matplotlib, papermill
RUN pip3 install nibabel matplotlib papermill notebook

# Add non-root user
RUN useradd --create-home --shell /bin/bash fsluser
USER fsluser
WORKDIR /home/fsluser
ENV USER=fsluser

COPY dwi_preproc.ipynb /usr/

ENTRYPOINT ["papermill", "/usr/dwi_preproc.ipynb"]
