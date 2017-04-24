### Welcome to FFV-C Pages.
Frontflow/violet Cartesian is a three-dimensional unsteady incompressible thermal flow simulator on a Cartesian grid system. This solver is designed so as to assist practical design in industry fields by powerful voxel based approach and to achieve higher parallel performance on massively parallel computers.

### How to install the package?
It is very simple to install this software package into your computer system. If your system already has compilers and MPI library, just type as follows after download the package. The default install directory is /usr/local/FFV.

```
$ tar xvfz avr-aics-riken-ffvc_package-x.x.x.tar.gz
$ cd avr-aics-riken-ffvc_package-x.x.x
$ export CC=... CXX=... F90=... FC=...
$ ./install.sh <intel|fx10|K> <INST_DIR> {serial|mpi} {double|float}
```

### Copyright
- Copyright (c) 2007-2011 VCAD System Research Program, RIKEN.  All rights reserved.
- Copyright (c) 2011-2015 Institute of Industrial Science, The University of Tokyo.  All rights reserved.
- Copyright (c) 2012-2016 Advanced Institute for Computational Science, RIKEN.  All rights reserved.
- Copyright (c) 2016-2017 Research Institute for Information Technology(RIIT), Kyushu University.  All rights reserved.

### License
BSD (2-clause) license

### Authors and Contributors
- Kenji       Ono
- Masako      Iwata
- Tsuyoshi    Tamaki
- Yasuhiro    Kawashima
- Kei         Akasaka
- Soichiro    Suzuki
- Junya       Onishi
- Ken         Uzawa
- Kazuhiro    Hamaguchi
- Yohei       Miyazaki
- Masashi     Imano

### Support or Contact
keno@{cc.kymushu-u.ac, riken}.jp

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-54226321-1', 'auto');
  ga('send', 'pageview');

</script>
