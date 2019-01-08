UBOS Manifest
=============

Each :term:`App` or :term:`Accessory` on UBOS has a ``ubos-manifest.json`` file, which contains
the meta-data that allows UBOS to correctly deploy, undeploy, backup, restore, upgrade
etc. the :term:`App` or :term:`Accessory`. It optionally also contains human-readable information
about the package. This file augments the information in the ``PKGBUILD`` file used by
the pacman package manager that UBOS invokes.

This section describes the UBOS manifest and how to use it.

.. toctree::
   :maxdepth: 1

   manifest/structure
   manifest/info
   manifest/roles
   manifest/customizationpoints
   manifest/appinfo
   manifest/accessoryinfo
   manifest/variables
   manifest/functions
   manifest/random
   manifest/scripts
