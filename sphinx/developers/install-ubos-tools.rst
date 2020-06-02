Finishing the Arch development installation by adding UBOS tools
================================================================

This applies to any physical or virtual machine that runs Arch.

Add the UBOS tools repository
-----------------------------

First, download and install the UBOS keyring, so pacman will allow you to download
and install UBOS tools:

.. code-block:: none

   % curl -O http://depot.ubos.net/yellow/x86_64/os/ubos-keyring-0.8-1-any.pkg.tar.xz
   % sudo pacman -U ubos-keyring-0.8-1-any.pkg.tar.xz

The, as root, edit ``/etc/pacman.conf``, and append, at the end, the following section:

.. code-block:: none

   [ubos-tools-arch]
   Server = http://depot.ubos.net/yellow/$arch/ubos-tools-arch

This will get you the UBOS development tools in the yellow, aka beta, channel.


Install the ubos-tools-arch metapackage
---------------------------------------

Execute:

.. code-block:: none

   % sudo pacman -Sy
   % sudo pacman -S ubos-tools-arch

Now is a good time to install any other development tools you might want, such as:

.. code-block:: none

   % sudo pacman -S base-devel
   % sudo pacman -S git

You are now ready to develop for UBOS.

If you are new to UBOS, you may want to work through the :doc:`toy apps <toyapps>`.
To run those :term:`Apps <App>` or test run your own :term:`App`, you may want to set up a UBOS container
(preferred) or a dedicated UBOS test machine. Setup instructions are
:doc:`here <../users/installation>`.
