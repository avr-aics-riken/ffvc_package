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

#export FFV_HOME=hogehoge

export TMP_CCC=mpifccpx
export TMP_CXX=mpiFCCpx
export TMP_F90=mpifrtpx

#######################################


# library name
export TP_LIB=TextParser-1.6.3
export PM_LIB=PMlib-3.1.1
export PLY_LIB=Polylib-3.5.3
export CPM_LIB=CPMlib-2.0.5
export CDM_LIB=CDMlib-0.8.1
export FFVC=FFVC-2.3.8


# TextParser
#
echo
echo -----------------------------
echo Install TextParser
echo
if [ ! -d ${TP_LIB} ]; then
  tar xvzf ${TP_LIB}.tar.gz
fi
cd ${TP_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/TextParser \
             CXX=$TMP_CXX \
             CXXFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" --host=sparc64-unknown-linux-gnu
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
cd ${PM_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/PMlib \
             CXX=$TMP_CXX \
             CXXFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" --host=sparc64-unknown-linux-gnu \
             CC=$TMP_CCC \
             CFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" --host=sparc64-unknown-linux-gnu
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
cd ${PLY_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/Polylib \
             --with-parser=${FFV_HOME}/TextParser \
             --with-real=$PRCSN1 \
             CXX=$TMP_CXX \
             CXXFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" --host=sparc64-unknown-linux-gnu
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
cd ${CPM_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/CPMlib \
             --with-pm=${FFV_HOME}/PMlib \
             --with-parser=${FFV_HOME}/TextParser \
             --with-comp=FJ \
             --with-example=no \
             --with-f90example=no \
             --with-f90real=$PRCSN2 \
             CXX=$TMP_CXX \
             CXXFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" \
             FC=$TMP_F90 \
             F90=$TMP_F90 \
             F90FLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc" --host=sparc64-unknown-linux-gnu
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
cd ${CDM_LIB}/BUILD_DIR
../configure --prefix=${FFV_HOME}/CDMlib \
             --with-parser=${FFV_HOME}/TextParser \
             F90=$TMP_F90 \
             F90FLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc" \
             CXX=$TMP_CXX \
             CXXFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" --host=sparc64-unknown-linux-gnu
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
cd ${FFVC}/BUILD_DIR
../configure --prefix=${FFV_HOME}/FFVC \
             --with-cpm=${FFV_HOME}/CPMlib \
             --with-cdm=${FFV_HOME}/CDMlib \
             --with-pm=${FFV_HOME}/PMlib\
             --with-polylib=${FFV_HOME}/Polylib \
             --with-parser=${FFV_HOME}/TextParser \
             --with-comp=FJ \
             --with-precision=$PRCSN1 \
             CCC=$TMP_CCC \
             CFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" \
             CXX=$TMP_CXX \
             CXXFLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0" \
             F90FLAGS="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc" \
             F90=$TMP_F90 --host=sparc64-unknown-linux-gnu
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ../..

