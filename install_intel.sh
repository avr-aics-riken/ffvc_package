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

export FFVC_HOME=/usr/local/FFV

export TP=${FFVC_HOME}/TextParser
export PL=${FFVC_HOME}/Polylib
export CT=${FFVC_HOME}/Cutlib
export PM=${FFVC_HOME}/PMlib
export CPM=${FFVC_HOME}/CPMlib
export CDM=${FFVC_HOME}/CDMlib
export FFV=${FFVC_HOME}/FFVC

export TMP_CCC=mpicc
export TMP_CXX=mpicxx
export TMP_F90=mpif90

#######################################


# library name
export TP_LIB=TextParser-1.5.7
export PM_LIB=PMlib-2.1.4
export PLY_LIB=Polylib-3.4.7
export CUT_LIB=Cutlib-3.2.5
export CPM_LIB=CPMlib-1.2.2
export CDM_LIB=CDMlib-0.5.3
export FFVC=FFVC-1.9.6

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
            --with-real=$PRCSN1 \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3" 
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
            CXXFLAGS="-O3 -openmp" 
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
            --with-comp=INTEL \
            --with-f90example=no \
            --with-f90real=$PRCSN2 \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3" \
            FC=$TMP_F90 \
            F90=$TMP_F90 \
            F90FLAGS="-O3" 
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..



# CDMlib
#
echo
echo -----------------------------
echo CDMlib
echo
if [ ! -d ${CDM_LIB} ]; then
  tar xvzf ${CDM_LIB}.tar.gz
fi
cd ${CDM_LIB}
./configure --prefix=$CDM \
            --with-parser=$TP \
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
            --with-cdm=$CDM \
            --with-cut=$CT \
            --with-pm=$PM \
            --with-polylib=$PL \
            --with-parser=$TP \
            --with-comp=INTEL \
            --with-precision=$PRCSN1 \
            CCC=$TMP_CCC \
            CFLAGS="-O3" \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3 -openmp -par-report=3 -vec-report=2" \
            F90FLAGS="-O3 -Warn unused -fpp -openmp -par-report=3 -vec-report=2" \
            F90=$TMP_F90 
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..

