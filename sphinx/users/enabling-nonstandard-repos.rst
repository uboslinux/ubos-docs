Enabling non-standard package repositories
==========================================

UBOS repositories
-----------------

Like many other Linux distributions, UBOS is split into multiple package repositories.
By default, the following repositories are enabled:

* ``os``: contains the core operating system;
* ``tools``: contains useful tools for development;
* ``hl``: contains "head-less" applications.

On ``x86_64`` PCs, UBOS also has:

* ``virt``: for virtualization / VirtualBox support.

In addition, the following repositories are not enabled by default:

* ``os-experimental``: operating system components that so far, are deemed experimental,
  that may either not work sufficiently well, or that may be removed without notice.

* ``hl-experimental``: similar, experimental "head-less" applications.

* ``toyapps``: :term:`Apps <App>` that are useful for development or for understanding UBOS, but not
  ever intended to be run in production.

Each one of those repositories is defined in a separate file in directory
``/etc/pacman.d/repositories.d``. The difference between the enabled and disabled
repositories is simply that the data in the disabled files is "commented out".

To enable a disabled repository, find the corresponding file, open it in an editor, and
undo the "commenting out". For example, to enable the ``toyapps`` repo, edit
``/etc/pacman.d/repositories.d/toyapps``, and remove the leading ``#`` characters, so
the file looks as follows:

.. code-block:: none

   [toyapps]
   Server = http://depot.ubos.net/$channel/$arch/toyapps

Then, run ``ubos-admin update`` so ``pacman`` will pick up the new repository.

3rd-party repositories
----------------------

You can add additional files into ``/etc/pacman.d/repositories.d`` that specify additional
repositories. You can use one of the existing files in that directory as a template. Once
you have added the file, run ``ubos-admin update``, otherwise ``pacman`` will not pick up
your new repository.

Note two key distinctions between UBOS and its upstream distro Arch Linux:

* Do not edit the repositories in ``/etc/pacman.conf`` directly. UBOS will overwrite it
  there.

* You can use the symbol ``$channel`` in the URL to indicate the UBOS release channel.
