ffvc_package
============

Release package of FFV-C and related libraries.


Install
=======
Just type "./install_intel.sh" on Intel platform. Other platforms too.

Option : If you want to compile with double precision, please invoke install shell with 'double' option.
	
	$ ./install_intel.sh double



Platform and compilers
=======
	install_intel.sh; Intel arch. and Intel compiler
	install_gnu.sh;   Intel arch. and gnu compiler
	install_fx.sh;    Sparc fx arch. and Fujitsu compiler



Note
=======
1.8.2  2014-08-27
---
- Confrim compilation with double precision.

1.7.4  2014-03-19
---
- On some environemnt, currently, we have a problem.
- If you compile this package with Intel mpi, please add -mt_mpi for CFLAGS, CXXFLAGS and F90FLAGS in install_intel.sh. Also, In case you see an error message "missing path to POLYmpi" when ffvc is invoked, please add path to POLYmpi for LD_LIBRARY_PATH.
