#!/bin/bash

function optional_dependencies { 
    local optional_dependencies_var;
    if [ -n "${WITH_JPEG+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var jpeg jpeg-dev"; 
    fi
    if [ -n "${WITH_PROJ+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var proj proj-dev"; 
    fi
    if [ -n "${WITH_TIFF+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var tiff tiff-dev"; 
    fi
    if [ -n "${WITH_GDAL+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var gdal gdal-dev"; 
    fi
    if [ -n "${WITH_CAIRO+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var cairo cairo-dev"; 
    fi
    echo $optional_dependencies_var
}

apk add --no-cache $(cat required_dependencies.txt) $(optional_dependencies)