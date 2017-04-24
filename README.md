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


## Install
Type install shell script on command line with options .

~~~
$ export CC=... CXX=... F90=... FC=...
$ ./install.sh <intel|fx10|K> <INST_DIR> {serial|mpi} {double|float}
~~~


## Supported platforms and compilers

* Linux Intel arch., Intel/GNU compilers.
* Mac OSX, Intel/GNU compilers.
* Sparc fx arch. and Fujitsu compiler.



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

