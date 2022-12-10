FROM httpd:2-alpine3.17

ARG WITH_JPEG
ARG WITH_PROJ
ARG WITH_TIFF
ARG WITH_PG
ARG WITH_GDAL
ARG WITH_SQLITE
ARG WITH_CAIRO

RUN apk add --no-cache g++ make python3 git patch bash

RUN git clone https://github.com/mapnik/mapnik.git
WORKDIR mapnik
RUN git submodule update --init
COPY SConstruct_fvisibility.patch SConstruct_fvisibility.patch
COPY optional_dependencies.sh optional_dependencies.sh
COPY build_dependencies.txt build_dependencies.txt
RUN patch SConstruct SConstruct_fvisibility.patch
RUN bash optional_dependencies.sh

RUN PYTHON=python3 ./configure
RUN PYTHON=python3 QUIET=yes HEAVY_JOBS=$(($(nproc)-2)) JOBS=$(($(nproc)-2)) make
RUN PYTHON=python3 make install
WORKDIR /