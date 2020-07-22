
FROM jupyter/base-notebook:python-3.7.6

ARG BRAINRENDER_VERSION=0.4.0.0

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf \
    && apt-get update && apt-get install \
    libhdf5-serial-dev \
    libhdf5-dev \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    x11-utils \
    libx11-dev \
    qt5-default \
    xvfb \
    build-essential \
# Cleanup
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

USER $NB_UID
WORKDIR $HOME

# http://www.pytables.org/usersguide/installation.html
RUN env CPPFLAGS=-I/usr/include/hdf5/serial \
	LDFLAGS=-L/usr/lib/x86_64-linux-gnu/hdf5/serial pip install --user tables==3.5.1

# Install Python 3 packages
RUN pip install install --user brainrender=="${BRAINRENDER_VERSION}" \
    'panel==0.9.7' \
    && \
    conda clean --all -f -y && \
    jupyter lab build -y && \
    jupyter lab clean -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions

COPY start_xvfb.sh /sbin/start_xvfb.sh

ENV DISPLAY=:99

ENTRYPOINT ["tini", "-g", "--", "xvfb-run"]
