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
    if [ -n "${WITH_SQLITE+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var sqlite sqlite-dev"; 
    fi
    if [ -n "${WITH_PG+1}" ]; then 
      optional_dependencies_var="$optional_dependencies_var postgresql postgresql-dev"; 
    fi
    echo $optional_dependencies_var
}

if [[ -f build_dependencies.txt ]]; then
  apk add --no-cache $(cat build_dependencies.txt) $(optional_dependencies)
else
  apk add --no-cache $(optional_dependencies)
fi