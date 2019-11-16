# FFVC_package

Release package of FFVC and related libraries.



## Copyright
- Copyright (c) 2007-2011 VCAD System Research Program, RIKEN.  All rights reserved.
- Copyright (c) 2011-2015 Institute of Industrial Science, The University of Tokyo.  All rights reserved.
- Copyright (c) 2012-2016 Advanced Institute for Computational Science, RIKEN.  All rights reserved.
- Copyright (c) 2016-2017 Research Institute for Information Technology(RIIT), Kyushu University.  All rights reserved.


## Software Requirement

- Cmake
- MPI library (In case of parallel version)
- TextParser (included in this package)
- PMlib (included in this package)
- Polylib (included in this package)
- CPMlib (included in this package)
- CDMlib (included in this package)
- PAPI (option)


## Install
Type install shell script on command line with options .

~~~
$ export CC=... CXX=... F90=... FC=...
$ ./install.sh <intel|fx10|K|intel_F_TCS> <INST_DIR> {serial|mpi} {double|float} papi={off|on}
~~~

Examples

~~~
MAC gcc mpi
$ export CC=mpicc CXX=mpicxx F90=mpif90 FC=mpif90
$ ./install.sh intel ${HOME}/FFVC mpi float papi=off
~~~


## Supported platforms and compilers

* Linux Intel arch., Intel/GNU compilers.
* Mac OSX, Intel/GNU compilers.
* Sparc fx arch. and Fujitsu compiler.


## Kyushu University ITO system

### Intel

#### PAPI

~~~
	$ module load intel/2018.3 openmpi/2.1.3-nocuda-intel18.0
	$ export CC=mpiicc CXX=mpiicpc F90=mpiifort FC=mpiifort
 	$ ./configure --prefix=${HOME}/FFV/PAPI
 	$ make && make install
~~~

#### ffvc_package

~~~
	$ module load intel/2018.3 openmpi/2.1.3-nocuda-intel18.0
	$ export CC=mpiicc CXX=mpiicpc F90=mpiifort FC=mpiifort
	$ ./install intel ${HOME}/FFV mpi float papi=on
	$ mpiexec.hydra -n 8 ./ffvc-mpi hoge.tp
~~~

---

### TCS

#### PAPI
~~~
$ export CC=mpifcc CXX=mpiFCC F77=mpifrt CFLAGS=-Xg CXXFLAGS=-Xg
$ ./configure --prefix=${HOME}/FFV/PAPI
$ make
$ make install
~~~

#### FFVC
~~~
$ ./install intel_F_TCS ${HOME}/FFV mpi float papi=on
~~~


## Contributors

- Kenji Ono *keno@cc.kyushu-u.ac.jp*
- Masako Iwata
- Tsuyoshi Tamaki
- Yasuhiro Kawashima
- Kei Akasaka
- Soichiro Suzuki
- Junya Onishi
- Ken Uzawa
- Kazuhiro Hamaguchi
- Yohei Miyazaki
- Masashi Imano

