Run UBOS in a Linux container
=============================

To run UBOS in a Linux container, it is easiest to:

 1. Install UBOS in a directory, say ``~/ubos``

 2. Execute::

       cd ~
       sudo systemd-nspawn -bD ubos/

To install UBOS in a directory, on an UBOS system, invoke::

   cd ~
   mkdir ubos
   sudo ubos-install --directory ubos
