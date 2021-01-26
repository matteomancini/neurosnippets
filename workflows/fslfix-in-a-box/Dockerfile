FROM ubuntu:bionic-20201119

# Install fundamental packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    lsb-core \
    bsdtar \
    zip \
    unzip \
    gzip \
    curl \
    jq \
    wget \
    python-pip \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#############################################
# Download and install R and necessary packages

ENV TZ=Europe/Rome
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y --no-install-recommends r-base r-cran-devtools \
        libblas-dev liblapack-dev gfortran r-cran-catools r-cran-gplots g++ && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    Rscript -e 'require(devtools); install_version("kernlab", version="0.9-24")' && \
    Rscript -e 'require(devtools); install_version("ROCR", version="1.0-7")' && \
    Rscript -e 'require(devtools); install_version("class", version="7.3-14")' && \
    Rscript -e 'require(devtools); install_version("mvtnorm", version="1.0-8")' && \
    Rscript -e 'require(devtools); install_version("multcomp", version="1.4-8")' && \
    Rscript -e 'require(devtools); install_version("coin", version="1.2-2")' && \
    Rscript -e 'require(devtools); install_version("party", version="1.0-25")' && \
    Rscript -e 'require(devtools); install_version("e1071", version="1.6-7")' && \
    Rscript -e 'require(devtools); install_version("randomForest", version="4.6-12")'

#############################################
# Download and install FIX

RUN wget -v http://www.fmrib.ox.ac.uk/~steve/ftp/fix.tar.gz && \
    mkdir -p /tmp/fix && \
    cd /tmp/fix && \
    tar zxvf /fix.tar.gz --exclude="compiled/Darwin/" && \
    mv /tmp/fix/fix* /opt/fix && \
    rm /fix.tar.gz && \
    cd / && \
    rm -rf /tmp/* /var/tmp/*

ENV FSL_FIXDIR=/opt/fix
ENV PATH "$PATH:/opt/fix"

#############################################
# Download and install Matlab Compiler Runtime

RUN wget https://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip && \
    mkdir /opt/mcr && mkdir /mcr-install && cd mcr-install && \
    unzip /MCR_R2017b_glnxa64_installer.zip && \
    rm -rf /MCR_R2017b_glnxa64_installer.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    cd / && rm -rf mcr-install

ENV FSL_FIX_MCRROOT=/opt/mcr

#############################################
# Download and install FSL 5 + OpenJDK

RUN apt-get update && apt-get install -y dirmngr && \
    wget -O- http://neuro.debian.net/lists/bionic.de-fzj.full | \
    tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    apt-get update && apt-get install -y fsl-core fsl-atlases openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure FSL environment
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

#############################################
# Add non-root user

RUN useradd --create-home --shell /bin/bash fsluser
USER fsluser
WORKDIR /home/fsluser
ENV USER=fsluser
