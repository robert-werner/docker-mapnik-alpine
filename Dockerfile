FROM alpine

ARG WITH_JPEG
ARG WITH_PROJ
ARG WITH_TIFF
ARG WITH_PG
ARG WITH_GDAL
ARG WITH_SQLITE
ARG WITH_CAIRO

RUN apk update
RUN apk add --no-cache alpine-sdk bash
RUN mkdir /opt/mapnik
RUN mkdir src
WORKDIR src
RUN git clone https://github.com/mapnik/mapnik.git
WORKDIR mapnik
RUN git submodule update --init
ADD . .
RUN bash optional_dependencies.sh
RUN patch SConstruct SConstruct_fvisibility.patch
RUN PYTHON=python3 ./configure PREFIX=/opt/mapnik
RUN PYTHON=python3 QUIET=yes HEAVY_JOBS=4 JOBS=4 make
RUN PYTHON=python3 make install

