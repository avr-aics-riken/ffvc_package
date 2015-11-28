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
#
# Double precision Option
#
# $ ./install_*.sh double
#
#######################################

# Default Precision
export PRCSN1=float
export PRCSN2=4

arg=$1

if [ "${arg}" = "double" ]; then
export PRCSN1=double
export PRCSN2=8
fi

#######################################
# Edit MACRO for your target machine

export FFV_HOME=~/FFV
export TMP_LDFLAGS=-L/usr/local/gfortran/lib

export TMP_CCC=mpicc
export TMP_CXX=mpicxx
export TMP_F90=mpif90

#######################################


# library name
export TP_LIB=TextParser-1.6.5
export PM_LIB=PMlib-4.2.2
export PLY_LIB=Polylib-3.5.4
export CPM_LIB=CPMlib-2.1.2
export CDM_LIB=CDMlib-0.9.3
export FFVC=FFVC-2.4.2


# TextParser
#
echo
echo -----------------------------
echo Install TextParser
echo
if [ ! -d ${TP_LIB} ]; then
  tar xvzf ${TP_LIB}.tar.gz
fi
autoreconf -i
cd ${TP_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/TextParser \
             --with-comp=GNU \
             CXX=$TMP_CXX \
             CXXFLAGS="-O3" 
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..



# PMlib
#
echo
echo -----------------------------
echo Install PMlib
echo
if [ ! -d ${PM_LIB} ]; then
  tar xvzf ${PM_LIB}.tar.gz
fi
autoreconf -i
cd ${PM_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/PMlib \
             --with-comp=GNU \
             CXX=$TMP_CXX \
             CXXFLAGS="-O3"  \
             CC=$TMP_CCC \
             CFLAGS="-O3" 
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..



# Polylib
#
echo
echo -----------------------------
echo Install Polylib
echo
if [ ! -d ${PLY_LIB} ]; then
  tar xvzf ${PLY_LIB}.tar.gz
fi
autoreconf -i
cd ${PLY_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/Polylib \
             --with-parser=${FFV_HOME}/TextParser \
             --with-real=$PRCSN1 \
             CXX=$TMP_CXX \
             CXXFLAGS="-O3" 
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..




# CPMlib
#
echo
echo -----------------------------
echo Install CPMlib
echo
if [ ! -d ${CPM_LIB} ]; then
  tar xvzf ${CPM_LIB}.tar.gz
fi
autoreconf -i
cd ${CPM_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/CPMlib \
             --with-pm=${FFV_HOME}/PMlib \
             --with-parser=${FFV_HOME}/TextParser \
             --with-comp=GNU \
             --with-example=no \
             --with-f90example=no \
             --with-f90real=$PRCSN2 \
             CXX=$TMP_CXX \
             CXXFLAGS="-O3" \
             F90=$TMP_F90 \
             F90FLAGS="-O3"  \
             LDFLAGS=$TMP_LDFLAGS
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..



# CDMlib
#
echo
echo -----------------------------
echo CDMlib
echo
if [ ! -d ${CDM_LIB} ]; then
  tar xvzf ${CDM_LIB}.tar.gz
fi
autoreconf -i
cd ${CDM_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/CDMlib \
             --with-parser=${FFV_HOME}/TextParser \
             F90=$TMP_F90 \
             F90FLAGS="-O3" \
             CXX=$TMP_CXX \
             CXXFLAGS="-O3" 
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..



# FFVC
#
echo
echo -----------------------------
echo Install FFVC
echo
if [ ! -d ${FFVC} ]; then
  tar xvzf ${FFVC}.tar.gz
fi
autoreconf -i
cd ${FFVC}/BUILD_DIR
../configure --prefix=${FFV_HOME}/FFVC \
             --with-cpm=${FFV_HOME}/CPMlib \
             --with-cdm=${FFV_HOME}/CDMlib \
             --with-pm=${FFV_HOME}/PMlib\
             --with-polylib=${FFV_HOME}/Polylib \
             --with-parser=${FFV_HOME}/TextParser \
             --with-comp=GNU \
             --with-precision=$PRCSN1 \
             CCC=$TMP_CCC \
             CFLAGS="-O3" \
             CXX=$TMP_CXX \
             CXXFLAGS="-O3 -fopenmp" \
             F90FLAGS="-O3 -cpp -fopenmp -ffree-form --free-line-length-none" \
             F90=$TMP_F90  \
             LDFLAGS=$TMP_LDFLAGS
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..
