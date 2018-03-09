Beta 13 Release Notes
=====================

IMPORTANT: To upgrade
---------------------

This time only, upgrading an existing UBOS installation is a little more complicated
than it should be. Sorry about that. Please execute:

* ``sudo pacman -Sy``
* ``yes y | sudo pacman -S ubos-admin``
* ``sudo ubos-admin update``
* ``sudo ubos-admin setnetconfig <your-config-name>``

where ``<your-config-name>`` is the name of the network configuration that you have set
on your device: typically ``espressobin`` for ESPRESSObin, ``cloud`` on EC2, and
``client`` for the rest. See also :doc:`../../../users/networking`.

On the ESPRESSObin, you also need to update your boot loader arguments. First, execute
the commands in the previous paragraph. Then, reboot and enter the bootloader as you
did the first time you installed UBOS. In the boot loader, execute:

* for booting from an SD card:

  .. code-block:: none

     mmc dev 0
     ext4load mmc 0 $loadaddr /uEnv-sdcard.txt
     env import -t $loadaddr $filesize
     saveenv
     boot

* for booting from a SATA disk:

  .. code-block:: none

     scsi scan
     scsi dev 0
     ext4load scsi 0 $loadaddr /uEnv-sata.txt
     env import -t $loadaddr $filesize
     saveenv
     boot

For users
---------

* New features and improvements:

  * WiFi configuration is now possible (and easy!) using nothing else than the
    UBOS Staff: save the name of your WiFi network(s) and credentials to a file on the
    UBOS Staff, and when you boot your device with the Staff present, UBOS will automatically
    put your device on the WiFi network.

  * UBOS will now save certain information about the device on the UBOS Staff with
    which it is booted. This includes the device's IP address(es) and server-side SSH
    keys and thus makes it much easier to securely "find" headless UBOS devices on a
    large network that may have many other UBOS devices as well.

  * On x86_64 PCs, UBOS now can boot from either UEFI or BIOS. This means that a larger
    range of (very old and very new) PCs can run UBOS. For example, UBOS can now run on
    Intel Compute Sticks that only support UEFI boot.

  * Better documentation for how to set up a Tor "hidden service" website.

  * You can deploy several sites at once by providing to ``ubos-admin deploy -f`` a JSON
    file that has several Site JSON files in an array or hash.

  * ``ubos-install --noswap`` will not create a swap partition.

  * New command ``ubos-admin init-staff`` will take a USB stick in any shape, and turn
    it into a valid UBOS Staff. Note: This will irrevocably delete all data on the
    USB stick.

  * New command ``ubos-admin hostid`` displays a unique identifier of the current device,
    regardless of IP addresses or other network-related identifiers. This hostid is used
    on the UBOS Staff to identify information about this particular device.

  * ``ubos-admin backup`` and other commands that write files will now warn you if you
    are about to overwrite a file.

  * ``ubos-admin createsite`` now asks you to repeat your site administrator password.
    Added by popular request from people who mistyped their password.

  * The default UBOS "404 Page Not Found" page has gained a link to the top of the site.
    This is useful when a site has been rearranged and previously valid URLs 404.

  * The UBOS logo on the default front page has been updated to the new version.

* Other important changes:

  * The obsolete commands ``shutdown``, ``reboot`` and the like have been removed. Use the
    corresponding ``systemd`` commands, such as ``systemctl reboot`` or ``systemctl halt``.

  * When you upgrade from an existing UBOS installation, you may see the following message:
    ``Cannot update firewall; do not know current netconfig. Run "ubos-admin setnetconfig" once``
    and you should do exactly that. For example, if your network configuration is ``client``,
    run ``ubos-admin setnetconfig client``.

    You only need to do this once. But once you have, it allows UBOS to automatically open
    ports in the UBOS firewall when an app is installed that needs to open a non-standard port,
    something that was not possible before.

  * The license has been changed for the ``ubos-admin`` and related packages. See
    separate <a href="blog post

  * The ``ubos-admin`` packages are now licensed using what we call the
    "Personal Public License". See `separate blog post </blog/2018/03/02/ubos-license.html>`_
    explaining how it better fits the UBOS values.

* New Apps:

  * `Mastodon <https://joinmastodon.org/>`_ lets your run your own version of
    Twitter, with up to 500 characters per Tweet, ahem, Toot. It also lets you federate
    with other Mastodon instances run by other people, and various other kinds of
    decentralized microblogging services. As usual for apps on UBOS, it takes just one
    command.  To install, invoke ``ubos-admin createsite --tls`` and enter ``mastodon``
    as the name of the app.

    NOTE:  Mastodon requires TLS, so you need to specify ``--tls`` when
    creating your site.

  * `phpBB <https://www.phpbb.com/>`_ lets you run your own discussion boards
    on a site you control. No more need for Google Groups or the like. To install,
    invoke ``ubos-admin createsite`` and enter ``phpbb`` as the name of the app.

  * `River5 <http://scripting.com/river.html>`_ is the latest river-of-news RSS
    reader from RSS godfather `Dave Winer <http://scripting.com/>`_`. To install,
    invoke ``ubos-admin createsite`` and enter ``river`` (not ``river5``) as the name
    of the app.

  * The Bitcoin, Ethereum and Monero cryptocurrency daemons are now available in the
    UBOS repositories and can be run simply by executing ``pacman -S`` (for installation)
    and ``systemctl start`` (to start running). Note: these are the backends only, UBOS
    does not currently ship wallets or other user-facing functionality (which you
    would likely want to run on a different device, like your phone or PC, anyway).

  * Added the Wordpress plugin ``indieweb-press-this``.

* Important bug fixes:

  * You can now create a site at host ``*`` even if you also run a Tor site on the
    same device.

  * ``ubos-admin createsite -n -o <file>`` now works as expected.

  * ``ubos-admin deploy`` will now check the values of customization points against
    allowed regular expressions.

For developers
--------------

* Important changes and improvements:

  * The Python example applications have been migrated to Python 3.

  * Java 9 packages are now available, although Java 8 remains the UBOS default for now.

  * Accessories can now specify more than one app that they can be used with. While this
    is an unusual case, this allows an accessory to be used with several, perhaps
    customized, alternatives of the same app.

  * There's now a pre-defined variable ``${appconfig.cachedir}`` identifying a directory
    in which an app should store its cache data.

* Important bug fixes:

  * The app and accessory namespaces for variables are now cleanly separated, which
    previously they were not. This means that accessories, during install, cannot
    access the variables of their app (they should not have to anyway).

UBOS build and release process
------------------------------

* We now perform automated upgrade tests for many of the apps available on UBOS:
  we boot an "old" UBOS container image, install an app, and then upgrade it to the
  latest as you would when you type ``ubos-admin update``. This should make it even
  less likely that UBOS upgrades fail.

Known issues
------------

* ``ubos-install`` with a swap partition may put the root file system on
  a device that is inconsistent with the device in the bootloader configuration. To fix,
  edit the bootloader configuration (e.g. change ``/dev/sda2`` to ``/dev/sda3``).

* If you run ``ubos-admin update``, and UBOS reboots the system as part of this process,
  your deployed site(s) may not automatically reappear. Don't panic! (It turns out we
  `missed some quotes <https://github.com/uboslinux/ubos-admin/issues/409>`_.) To fix
  this situation and restore your sites, apps and data, log into your device, and execute
  ``ubos-admin update-stage2``.
