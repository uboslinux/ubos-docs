Release Notes: Update 2019-10-08
================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

Please refer to the main documentation for details.

Notable changes
---------------

This is mostly a package upgrade release with some small bug fixes and additions
to the documentation.

* More than 500 packages have been upgraded or newly added.

* The Arch installation instructions for developers have been updated to cover
  UEFI-only PCs.

.. Note:: On the ESPRESSObin, you need to update your boot loader, otherwise
   booting your system will fail. This is newly documented on the
   `ESPRESSObin install page <../../../users/installation/espressobin.html>`_.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.

