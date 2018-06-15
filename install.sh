#! /bin/sh
#
###################################################################################
#
# FFV-C : Frontflow / violet Cartesian
#
# Copyright (c) 2007-2011 VCAD System Research Program, RIKEN.
# All rights reserved.
#
# Copyright (c) 2011-2015 Institute of Industrial Science, The University of Tokyo.
# All rights reserved.
#
# Copyright (c) 2012-2016 Advanced Institute for Computational Science, RIKEN.
# All rights reserved.
#
# Copyright (c) 2016-2017 Research Institute for Information Technology(RIIT),
# Kyushu University.
# All rights reserved.
#
###################################################################################


#######################################
#
# Library version
#

export TP_LIB=TextParser-1.8.5
export PM_LIB=PMlib-5.6.6
export PL_LIB=Polylib-3.7.0
export CPM_LIB=CPMlib-2.4.4
export CDM_LIB=CDMlib-1.1.3
export FFVC=FFVC-2.5.3



#######################################
#
# Usage
#
# $ ./install.sh <intel|fx10|K|intel_F_TCS> <INST_DIR> {serial|mpi} {double|float}
#
#######################################


# Target machine
#
target_arch=$1

if [ "${target_arch}" = "intel" ]; then
  echo "Target arch       : intel"
elif [ "${target_arch}" = "fx10" ]; then
  echo "Target arch       : fx10"
  F_TCS="yes"
  toolchain_file="../cmake/Toolchain_fx10.cmake"
elif [ "${target_arch}" = "K" ]; then
  echo "Target arch       : K Computer"
  F_TCS="yes"
  toolchain_file="../cmake/Toolchain_K.cmake"
elif [ "${target_arch}" = "intel_F_TCS" ]; then
  echo "Target arch       : Intel Fujitsu TCS env."
  toolchain_file="../cmake/Toolchain_intel_F_TCS.cmake"
  F_TCS="yes"
else
  echo "Target arch       : not supported -- terminate install process"
  exit
fi


# Install directory
#
target_dir=$2

export INST_DIR=${target_dir}
echo "Install directory : ${INST_DIR}"


# Parallelism
#
parallel_mode=$3

if [ "${parallel_mode}" = "mpi" ]; then
  echo "Paralle mode.     : ${parallel_mode}"
  mode_mpi="yes"
elif [ "${parallel_mode}" = "serial" ]; then
  echo "Paralle mode.     : ${parallel_mode}"
  mode_mpi="no"
else
  echo "Paralle mode.     : Invalid -- terminate install process"
  exit
fi



# Floating point Precision
#
fp_mode=$4

if [ "${fp_mode}" = "double" ]; then
  export PRCSN=double
elif [ "${fp_mode}" = "float" ]; then
  export PRCSN=float
else
  echo "Invalid argument for floating point  -- terminate install process"
  exit
fi

echo "Precision         : ${fp_mode}"
echo " "


#######################################


# TextParser
#
echo
echo -----------------------------
echo Install TextParser
echo
if [ ! -d ${TP_LIB} ]; then
  tar xvzf ${TP_LIB}.tar.gz
  mkdir ${TP_LIB}/build
  cd ${TP_LIB}/build

  if [ "${target_arch}" = "intel" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/TextParser \
            -Dwith_MPI=${mode_mpi} ..

  elif [ "${F_TCS}" = "yes" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/TextParser \
            -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
            -Dwith_MPI=${mode_mpi} ..
  fi

  make
  if [ $? -ne 0 ]; then
    echo "make error!"
    exit
  fi
  make install
  cd ../..
else
  echo "${TP_LIB} is already exist. Skip compiling."
fi



# PMlib
#
echo
echo -----------------------------
echo Install PMlib
echo
if [ ! -d ${PM_LIB} ]; then
  tar xvzf ${PM_LIB}.tar.gz
  mkdir ${PM_LIB}/build
  cd ${PM_LIB}/build

  if [ "${target_arch}" = "intel" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/PMlib \
            -Denable_OPENMP=no \
            -Dwith_MPI=${mode_mpi} \
            -Denable_Fortran=no \
            -Dwith_example=no \
            -Dwith_PAPI=no \
            -Dwith_OTF=no ..

  elif [ "${F_TCS}" = "yes" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/PMlib \
            -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
            -Denable_OPENMP=no \
            -Dwith_MPI=${mode_mpi} \
            -Denable_Fortran=no \
            -Dwith_example=no \
            -Dwith_PAPI=no \
            -Dwith_OTF=no ..
  fi

  make
  if [ $? -ne 0 ]; then
    echo "make error!"
    exit
  fi
  make install
  cd ../..
else
  echo "${PM_LIB} is already exist. Skip compiling."
fi


# Polylib
#
echo
echo -----------------------------
echo Install Polylib
echo
if [ ! -d ${PL_LIB} ]; then
  tar xvzf ${PL_LIB}.tar.gz
  mkdir ${PL_LIB}/build
  cd ${PL_LIB}/build

  if [ "${target_arch}" = "intel" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/Polylib \
          -Dreal_type=${PRCSN} \
          -Dwith_MPI=${mode_mpi} \
          -Dwith_example=no \
          -Dwith_TP=${INST_DIR}/TextParser ..

  elif [ "${F_TCS}" = "yes" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/Polylib \
            -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
            -Dreal_type=${PRCSN} \
            -Dwith_MPI=${mode_mpi} \
            -Dwith_example=no \
            -Dwith_TP=${INST_DIR}/TextParser ..
  fi

  make
  if [ $? -ne 0 ]; then
    echo "make error!"
    exit
  fi
  make install
  cd ../..
else
  echo "${PL_LIB} is already exist. Skip compiling."
fi




# CPMlib
#
echo
echo -----------------------------
echo Install CPMlib
echo
if [ ! -d ${CPM_LIB} ]; then
  tar xvzf ${CPM_LIB}.tar.gz
  mkdir ${CPM_LIB}/build
  cd ${CPM_LIB}/build

  if [ "${target_arch}" = "intel" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/CPMlib \
            -Dwith_MPI=${mode_mpi} \
            -Dreal_type=${PRCSN} \
            -Denable_LMR=no \
            -Dwith_example=no \
            -Dwith_TP=${INST_DIR}/TextParser ..

  elif [ "${F_TCS}" = "yes" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/CPMlib \
            -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
            -Dwith_MPI=${mode_mpi} \
            -Dreal_type=${PRCSN} \
            -Denable_LMR=no \
            -Dwith_example=no \
            -Dwith_TP=${INST_DIR}/TextParser ..
  fi

  make
  if [ $? -ne 0 ]; then
    echo "make error!"
    exit
  fi
  make install
  cd ../..
else
  echo "${CPM_LIB} is already exist. Skip compiling."
fi



# CDMlib
#
echo
echo -----------------------------
echo CDMlib
echo
if [ ! -d ${CDM_LIB} ]; then
  tar xvzf ${CDM_LIB}.tar.gz
  mkdir ${CDM_LIB}/build
  cd ${CDM_LIB}/build

  if [ "${target_arch}" = "intel" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/CDMlib \
            -Dwith_MPI=${mode_mpi} \
            -Dwith_example=no \
            -Dwith_util=yes \
            -Dwith_TP=${INST_DIR}/TextParser \
            -Dwith_CPM=${INST_DIR}/CPMlib \
            -Dwith_NetCDF=no \
            -Dwith_HDF=no \
            -Denable_BUFFER_SIZE=no ..

  elif [ "${F_TCS}" = "yes" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/CDMlib \
            -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
            -Dwith_MPI=${mode_mpi} \
            -Dwith_example=no \
            -Dwith_util=yes \
            -Dwith_TP=${INST_DIR}/TextParser \
            -Dwith_CPM=${INST_DIR}/CPMlib \
            -Dwith_NetCDF=no \
            -Dwith_HDF=no \
            -Denable_BUFFER_SIZE=no ..
  fi

  make
  if [ $? -ne 0 ]; then
    echo "make error!"
    exit
  fi
  make install
  cd ../..
else
  echo "${CDM_LIB} is already exist. Skip compiling."
fi




# FFVC
#
echo
echo -----------------------------
echo Install FFVC
echo
if [ ! -d ${FFVC} ]; then
  tar xvzf ${FFVC}.tar.gz
  mkdir ${FFVC}/build
  cd ${FFVC}/build

  if [ "${target_arch}" = "intel" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/FFVC \
          -Dreal_type=${PRCSN} \
          -Denable_OPENMP=yes \
          -Dwith_MPI=${mode_mpi} \
          -Dwith_TP=${INST_DIR}/TextParser \
          -Dwith_PM=${INST_DIR}/PMlib \
          -Dwith_PL=${INST_DIR}/Polylib \
          -Dwith_CPM=${INST_DIR}/CPMlib \
          -Dwith_CDM=${INST_DIR}/CDMlib ..

  elif [ "${F_TCS}" = "yes" ]; then
    cmake -DINSTALL_DIR=${INST_DIR}/FFVC \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Dreal_type=${PRCSN} \
          -Denable_OPENMP=yes \
          -Dwith_MPI=${mode_mpi} \
          -Dwith_TP=${INST_DIR}/TextParser \
          -Dwith_PM=${INST_DIR}/PMlib \
          -Dwith_PL=${INST_DIR}/Polylib \
          -Dwith_CPM=${INST_DIR}/CPMlib \
          -Dwith_CDM=${INST_DIR}/CDMlib ..
  fi

  make
  if [ $? -ne 0 ]; then
    echo "make error!"
    exit
  fi
  make install
  cd ../..
else
  echo "${FFVC} is already exist. Skip compiling."
fi
