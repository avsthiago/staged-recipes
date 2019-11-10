#!/bin/bash

# Setup CMake build location
rm -rf build
mkdir build
cd build

# MPI variants
if [[ ${mpi} == "nompi" ]]; then
   export ENABLE_MPI="OFF"
else
   export ENABLE_MPI="ON"
fi

# configure with cmake
cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}"\
      -DENABLE_PYTHON=ON \
      -DENABLE_FORTRAN=ON \
      -DENABLE_MPI=${ENABLE_MPI} \
      -DPYTHON_MODULE_INSTALL_PREFIX="${SP_DIR}"\
      -DHDF5_DIR=${CONDA_PREFIX} \
      ../src

# build, test, and install
make
make test
make install
