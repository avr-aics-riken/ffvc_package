ffvc_package
============

Release package of FFV-C and related libraries.

1.7.4  2014-03-19
	On some environemnt, currently, we have a problem.
	If you compile this package with Intel mpi, please add -mt_mpi for CFLAGS, CXXFLAGS and F90FLAGS
	in install_intel.sh. Also, In case you see an error message "missing path to POLYmpi" when ffvc 
	is invoked, please add path to POLYmpi for LD_LIBRARY_PATH.
