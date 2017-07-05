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

export TP_LIB=TextParser-1.8.2
export PM_LIB=PMlib-5.6.1
export PL_LIB=Polylib-3.6.5
export CPM_LIB=CPMlib-2.4.0
export CDM_LIB=CDMlib-1.1.0
export FFVC=FFVC-2.5.1



#######################################
#
# Usage
#
# $ ./install.sh <intel|fx10|K> <target_dir> {serial|mpi} {double|float}
#
#######################################


# Target machine
#
target_arch=$1

if [ "${target_arch}" = "intel" ]; then
  echo "Target arch       : intel"
elif [ "${target_arch}" = "fx10" ]; then
  echo "Target arch       : fx10"
  sparcv9="yes"
  toolchain_file="../cmake/Toolchain_fx10.cmake"
elif [ "${target_arch}" = "K" ]; then
  echo "Target arch       : K Computer"
  sparcv9="yes"
  toolchain_file="../cmake/Toolchain_K.cmake"
else
  echo "Target arch       : not supported -- terminate install process"
  exit
fi


# Install directory
#
target_dir=$2
echo "Install directory : ${target_dir}"


# Parallelism
#
is_par=$3

if [ "${is_par}" = "mpi" ]; then
  p_mode="yes"
elif [ "${is_par}" = "serial" ]; then
  p_mode="no"
else
  echo "Paralle mode.     : Invalid -- terminate install process"
  exit
fi

echo "Paralle mode.     : ${is_par}"


# Floating point Precision
#
fp_mode=$4

if [ "${fp_mode}" = "double" ]; then
  precision=double
elif [ "${fp_mode}" = "float" ]; then
  precision=float
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
    cmake -DINSTALL_DIR=${target_dir}/TextParser -Dwith_MPI=${p_mode} ..

  elif [ "${sparcv9}" = "yes" ]; then
    cmake -DINSTALL_DIR=${target_dir}/TextParser \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Dwith_MPI=${p_mode} ..
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
    cmake -DINSTALL_DIR=${target_dir}/PMlib \
          -Denable_OPENMP=no \
          -Dwith_MPI=${p_mode} \
          -Denable_Fortran=no \
          -Dwith_example=no \
          -Dwith_PAPI=no \
          -Dwith_OTF=no ..

  elif [ "${sparcv9}" = "yes" ]; then
    cmake -DINSTALL_DIR=${target_dir}/PMlib \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Denable_OPENMP=no \
          -Dwith_MPI=${p_mode} \
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
    cmake -DINSTALL_DIR=${target_dir}/Polylib \
          -Dreal_type=${precision} \
          -Dwith_MPI=${p_mode} \
          -Dwith_example=no \
          -Dwith_TP=${target_dir}/TextParser ..

  elif [ "${sparcv9}" = "yes" ]; then
    cmake -DINSTALL_DIR=${target_dir}/Polylib \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Dreal_type=${precision} \
          -Dwith_MPI=${p_mode} \
          -Dwith_example=no \
          -Dwith_TP=${target_dir}/TextParser ..
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
    cmake -DINSTALL_DIR=${target_dir}/CPMlib \
          -Dwith_MPI=${p_mode} \
          -Dreal_type=${precision} \
          -Denable_LMR=no \
          -Dwith_example=no \
          -Dwith_TP=${target_dir}/TextParser ..

  elif [ "${sparcv9}" = "yes" ]; then
    cmake -DINSTALL_DIR=${target_dir}/CPMlib \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Dwith_MPI=${p_mode} \
          -Dreal_type=${precision} \
          -Denable_LMR=no \
          -Dwith_example=no \
          -Dwith_TP=${target_dir}/TextParser ..
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
    cmake -DINSTALL_DIR=${target_dir}/CDMlib \
          -Dwith_MPI=${p_mode} \
          -Dwith_example=no \
          -Dwith_util=yes \
          -Dwith_TP=${target_dir}/TextParser \
          -Dwith_CPM=${target_dir}/CPMlib \
          -Dwith_NetCDF=no \
          -Denable_BUFFER_SIZE=no ..

  elif [ "${sparcv9}" = "yes" ]; then
    cmake -DINSTALL_DIR=${target_dir}/CDMlib \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Dwith_MPI=${p_mode} \
          -Dwith_example=no \
          -Dwith_util=yes \
          -Dwith_TP=${target_dir}/TextParser \
          -Dwith_CPM=${target_dir}/CPMlib \
          -Dwith_NetCDF=no \
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
    cmake -DINSTALL_DIR=${target_dir}/FFVC \
          -Dreal_type=${precision} \
          -Denable_OPENMP=yes \
          -Dwith_MPI=${p_mode} \
          -Dwith_TP=${target_dir}/TextParser \
          -Dwith_PM=${target_dir}/PMlib \
          -Dwith_PL=${target_dir}/Polylib \
          -Dwith_CPM=${target_dir}/CPMlib \
          -Dwith_CDM=${target_dir}/CDMlib ..

  elif [ "${sparcv9}" = "yes" ]; then
    cmake -DINSTALL_DIR=${target_dir}/FFVC \
          -DCMAKE_TOOLCHAIN_FILE="${toolchain_file}" \
          -Dreal_type=${precision} \
          -Denable_OPENMP=yes \
          -Dwith_MPI=${p_mode} \
          -Dwith_TP=${target_dir}/TextParser \
          -Dwith_PM=${target_dir}/PMlib \
          -Dwith_PL=${target_dir}/Polylib \
          -Dwith_CPM=${target_dir}/CPMlib \
          -Dwith_CDM=${target_dir}/CDMlib ..
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
