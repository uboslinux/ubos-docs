UBOS Manifest
=============

Each app or accessory on UBOS has a ``ubos-manifest.json`` file, which declares how
the app or accessory would like to be installed, uninstalled, backed-up, upgraded etc.
While UBOS package management upgrades the code of the app or accessory, the UBOS manifest
describes how each installation of the app or accessory (e.g. a different virtual hosts
on the same device) needs to be configured.

This section describes the UBOS manifest and how to use it.

.. toctree::
   :maxdepth: 1

   manifest/variables
   manifest/functions
   manifest/random
   manifest/perlscript

