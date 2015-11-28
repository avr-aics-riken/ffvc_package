# ffvc_package

Release package of FFV-C and related libraries.


## Install
1) edit environment variables
  
FFV_HOME = Install directory, default directory is ~/FFV
TMP_LDFLAGS = Directory path for fortran libraries

In case of the GNU compiler, you may need to specify TMP_LDFLAGS, that includes
fortran library.



2) Type install shell script. For example, install_intel.sh for Intel platform.
  $ ./install_intel.sh



3) If you want to compile with double precision, please invoke install shell with 'double' option.
  $ ./install_intel.sh double



## Supported platforms and compilers
	install_intel.sh; Intel arch. and Intel compiler
	install_gnu.sh;   Intel arch. and gnu compiler
	install_fx.sh;    Sparc fx arch. and Fujitsu compiler



## Note

### 2.0.8 `2015-02-01`
- new algorithm for a geometry process
- 9 bits expression for cut length
- expire exploiting cutlib

### 1.8.5 `2014-09-16`
- Implement central scheme 2nd & 4th 
