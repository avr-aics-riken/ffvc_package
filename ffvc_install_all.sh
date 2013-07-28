#! /bin/sh
#


#######################################
# Edit MACRO for your target machine

export TP=/usr/local/TextParser
export PL=/usr/local/Polylib
export CT=/usr/local/Cutlib
export PM=/usr/local/PMlib
export CPM=/usr/local/CPMlib
export CIO=/usr/local/CIOlib
export FFV=/usr/local/FFVC

export TMP_CXX=mpicxx
export TMP_F90=mpif90

#######################################



# decompress

tar xvfz TextParser-?.?.?.tar.gz
tar xvfz PMlib-?.?.?.tar.gz
tar xvfz Polylib-?.?.?.tar.gz
tar xvfz Cutlib-?.?.?.tar.gz
tar xvfz CPMlib-?.?.?.tar.gz
tar xvfz CIOlib-?.?.?.tar.gz
tar xvfz FFVC-?.?.?.tar.gz



# TextParser
#
echo
echo -----------------------------
echo Install TextParser
echo
cd TextParser-?.?.?
./configure --prefix=$TP \
            CXX=$TMP_CXX \
            CXXFLAGS=-O3
make && make install
cd ..



# PMlib
#
echo
echo -----------------------------
echo Install PMlib
echo
cd PMlib-?.?.?
./configure --prefix=$PM \
            CXX=$TMP_CXX \
            CXXFLAGS=-O3
make && make install
cd ..



# Polylib
#
echo
echo -----------------------------
echo Install Polylib
echo
cd Polylib-?.?.?
./configure --prefix=$PL \
            --with-parser=$TP \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3 -Wall -fno-strict-aliasing"
make && make install
cd ..



# Cutlib
#
echo
echo -----------------------------
echo Install Cutlib
echo
cd Cutlib-?.?.?
./configure --prefix=$CT \
            --with-parser=$TP \
            --with-polylib=$PL \
            CXX=icpc \
            CXXFLAGS="-O3 -Wall -openmp"
make && make install
cd ..



# CPMlib
#
echo
echo -----------------------------
echo Install CPMlib
echo
cd CPMlib-?.?.?
./configure --prefix=$CPM \
            --with-pm=$PM \
            --with-parser=$TP \
            --with-comp=INTEL \
            CXX=$TMP_CXX \
            CXXFLAGS=-O3 \
            F90=$TMP_F90 \
            F90FLAGS=-O3
make && make install
cd ..



# CIOlib
#
echo
echo -----------------------------
echo CIOlib
echo
cd CIOlib-?.?.?
./configure --prefix=$CIO \
            --with-parser=$TP \
            CXX=$TMP_CXX \
            CXXFLAGS=-O3
make && make install
cd ..



# FFVC
#
echo
echo -----------------------------
echo Install FFVC
echo
cd FFVC-?.?.?
./configure --prefix=$FFV \
            --with-cpm=$CPM \
            --with-cio=$CIO \
            --with-cut=$CT \
            --with-pm=$PM \
            --with-polylib=$PL \
            --with-parser=$TP \
            --with-comp=INTEL \
            CC=mpicc \
            CFLAGS=-O3 \
            CXX=$TMP_CXX \
            CXXFLAGS="-O3 -openmp -par-report=3 -vec-report=2" \
            F90=$TMP_F90 \
            F90FLAGS="-O3 -Warn unused -fpp -openmp -par-report=3 -vec-report=2"
make && make install
cd ..
