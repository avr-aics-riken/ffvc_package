#! /bin/sh
#


#######################################
# Edit MACRO for your target machine

export FFVC_HOME=${HOME}/tmp

export TP=${FFVC_HOME}/TextParser
export PL=${FFVC_HOME}/Polylib
export CT=${FFVC_HOME}/Cutlib
export PM=${FFVC_HOME}/PMlib
export CPM=${FFVC_HOME}/CPMlib
export CIO=${FFVC_HOME}/CIOlib
export FFV=${FFVC_HOME}/FFVC

export TMP_CC=mpifccpx
export TMP_CXX=mpiFCCpx
export TMP_F90=mpifrtpx

export OPTC="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0"
export OPTF="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc"

#######################################



# library name
export TP_LIB=TextParser-1.4.5
export PM_LIB=PMlib-1.9.9
export PLY_LIB=Polylib-2.7.3
export CUT_LIB=Cutlib-3.1.8
export CPM_LIB=CPMlib-1.1.5
export CIO_LIB=CIOlib-1.4.3
export FFVC=FFVC-1.5.5

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
            CXXFLAGS="$OPTC" \
            --host=sparc64-unknown-linux-gnu
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
            CXXFLAGS="$OPTC" \
            --host=sparc64-unknown-linux-gnu
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
            CXXFLAGS="$OPTC" \
            --host=sparc64-unknown-linux-gnu
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
            CXXFLAGS="$OPTC" \
            --host=sparc64-unknown-linux-gnu
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
            CXX=$TMP_CXX \
            CXXFLAGS="$OPTC" \
            F90=$TMP_F90 \
            F90FLAGS="$OPTF" \
            --host=sparc64-unknown-linux-gnu \
            --with-f90example=no
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
            CXX=$TMP_CXX \
            CXXFLAGS="$OPTC" \
            F90=$TMP_F90 \
            F90FLAGS="$OPTF" \
            --host=sparc64-unknown-linux-gnu
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
            --with-comp=FJ \
            CC=$TMP_CC \
            CFLAGS="$OPTC" \
            CXX=$TMP_CXX \
            CXXFLAGS="$OPTC" \
            F90=$TMP_F90 \
            F90FLAGS="$OPTF" \
            --host=sparc64-unknown-linux-gnu
make
if [ $? -ne 0 ]; then
  echo "make error!"
  exit
fi
make install
cd ..

