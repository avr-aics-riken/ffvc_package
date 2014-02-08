#! /bin/sh
#
##############################################################################
#
# FFV-C Install Shell 
#
# Copyright (c) 2014 Advanced Institute for Computational Science, RIKEN.
# All rights reserved.
#

#######################################
# Edit MACRO for your target machine

export FFVC_HOME=/usr/local/FFV

export TP=${FFVC_HOME}/TextParser
export PL=${FFVC_HOME}/Polylib
export CT=${FFVC_HOME}/Cutlib
export PM=${FFVC_HOME}/PMlib
export CPM=${FFVC_HOME}/CPMlib
export CIO=${FFVC_HOME}/CIOlib
export FFV=${FFVC_HOME}/FFVC

export TMP_CC=mpicc
export TMP_CXX=mpicxx
export TMP_F90=mpif90

#######################################


# library name
export TP_LIB=TextParser-1.4.5
export PM_LIB=PMlib-1.9.9
export PLY_LIB=Polylib-2.7.3
export CUT_LIB=Cutlib-3.2.0
export CPM_LIB=CPMlib-1.1.5
export CIO_LIB=CIOlib-1.5.0
export FFVC=FFVC-1.5.8

# TextParser
#
echo
echo -----------------------------
echo Install TextParser
echo
if [ ! -d ${TP_LIB} ]; then
  tar xvzf ${TP_LIB}.tar.gz
fi
cd ${TP_LIB}
./configure --prefix=$TP \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3"
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# PMlib
#
echo
echo -----------------------------
echo Install PMlib
echo
if [ ! -d ${PM_LIB} ]; then
  tar xvzf ${PM_LIB}.tar.gz
fi
cd ${PM_LIB}
./configure --prefix=$PM \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3"
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# Polylib
#
echo
echo -----------------------------
echo Install Polylib
echo
if [ ! -d ${PLY_LIB} ]; then
  tar xvzf ${PLY_LIB}.tar.gz
fi
cd ${PLY_LIB}
./configure --prefix=$PL \
            --with-parser=$TP \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3 -Wall -fno-strict-aliasing"
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# Cutlib
#
echo
echo -----------------------------
echo Install Cutlib
echo
if [ ! -d ${CUT_LIB} ]; then
  tar xvzf ${CUT_LIB}.tar.gz
fi
cd ${CUT_LIB}
./configure --prefix=$CT \
            --with-parser=$TP \
            --with-polylib=$PL \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3 -Wall -fopenmp"
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# CPMlib
#
echo
echo -----------------------------
echo Install CPMlib
echo
if [ ! -d ${CPM_LIB} ]; then
  tar xvzf ${CPM_LIB}.tar.gz
fi
cd ${CPM_LIB}
./configure --prefix=$CPM \
            --with-pm=$PM \
            --with-parser=$TP \
            --with-comp=FJ \
            --with-f90example=no \
            CXX=$TMP_CXX \
            CXXFLAGS=-O3 \
            FC=$TMP_F90 \
            F90=$TMP_F90 \
            F90FLAGS=-O3
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# CIOlib
#
echo
echo -----------------------------
echo CIOlib
echo
if [ ! -d ${CIO_LIB} ]; then
  tar xvzf ${CIO_LIB}.tar.gz
fi
cd ${CIO_LIB}
./configure --prefix=$CIO \
            --with-parser=$TP \
            F90=$TMP_F90 \
            F90FLAGS="-O3" \
            CXX=$TMP_CXX \
            CXXFLAGS=-O3
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# FFVC
#
echo
echo -----------------------------
echo Install FFVC
echo
if [ ! -d ${FFVC} ]; then
  tar xvzf ${FFVC}.tar.gz
fi
cd ${FFVC}
./configure --prefix=$FFV \
            --with-cpm=$CPM \
            --with-cio=$CIO \
            --with-cut=$CT \
            --with-pm=$PM \
            --with-polylib=$PL \
            --with-parser=$TP \
            --with-comp=GNU \
            CC=$TMP_CC \
            CFLAGS="-O3" \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3 -fopenmp" \
            F90=$TMP_F90 \
            F90FLAGS="-O3 -cpp -fopenmp -ffree-form"
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..

