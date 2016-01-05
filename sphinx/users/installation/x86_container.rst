Run UBOS in a Linux container on a PC (64bit)
=============================================

If you already run Linux on a 64bit PC, you can run UBOS in a Linux container with
`systemd-nspawn`. This allows you to try out UBOS without having to do a bare metal installation.
The only requirement is that your Linux machine runs `systemd` in a recent version.

We tested against `systemd` versions 219 and later:

* running UBOS in a container within UBOS;
* running UBOS in a container within Arch Linux.

Chances are it also works on other `systemd`-based distros.

To do so:

#. Download a UBOS container image from `depot.ubos.net`.
   Beta images for x86_64 containers are at
   `http://depot.ubos.net/yellow/x86_64/images <http://depot.ubos.net/yellow/x86_64/images>`_.
   Look for a file named ``ubos_yellow_container-x86_64_LATEST.tar.xz``.

#. Uncompress and unpack the downloaded file into a suitable directory by executing:

   .. code-block:: none

      > mkdir ubos
      > tar -x -J -C ubos -f ubos_yellow_container-pc_LATEST.tar.xz

   on the command line.

   If you are running btrfs as your filesystem, you may want to create a subvolume and
   unpack into that subvolume instead, as `systemd-nspawn` is btrfs-aware and that can speed
   up things and save some disk space. However, btrfs is optional.

#. Boot the container. `systemd-nspawn` has a wide variety of options, in particular
   for how to set up networking. A private network, as we do it here, is one simple
   option, but you may want to choose a different option, depending on your needs:

   .. code-block:: none

      > sudo systemd-nspawn --boot --network-veth --machine ubos --directory ubos

#. When the boot process is finished, log in as user ``root``. By default, there is no
   password on the console.

#. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes
   on slower platforms. To determine whether UBOS ready, execute:

   .. code-block:: none

      > systemctl is-system-running

   The container takes entropy from the host computer, so make sure the host Linux system
   provides enough. Depending your Linux distro, you may be able to generate more by
   typing on the keyboard, moving the mouse, generating hard drive activity etc. You can
   also run:

   .. code-block:: none

      > sudo systemctl start haveged

   on your host (not container).

#. Your container should automatically acquire an IP address. You can check with:

   .. code-block:: none

      > ip addr

   Make sure you are connected to the internet before attempting to proceed. If you
   have difficulties reaching the internet from your container, consult the
   :doc:`troubleshooting page<../troubleshooting>`.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`. Note
   that with the private networking setup described on this page, you will only be able
   to access apps installed in your UBOS container from the host computer. If you like to
   access them from anywhere else, you either need to give your container a non-private
   IP address, or port forward from the host to the container.

#. To shut down your container, either:

   * hit ^] three times, or
   * in a separate shell, execute `sudo machinectl poweroff ubos`
