Beta 13 Release Notes
=====================

There are lots of new features and improvements in this release.

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

  * The default UBOS "404 Page Not Found" page has gained a link to the top of the site.
    This is useful when a site has been rearranged and previously valid URLs 404.

  * The UBOS logo on the default front page has been updated to the new version.

* Other important changes:

  * The obsolete commands ``shutdown``, ``reboot`` and the like have been removed. Use the
    coresponding ``systemd`` commands, such as ``systemctl reboot`` or ``systemctl halt``.

  * When you upgrade from an existing UBOS installation, you may see the following message:
    ``Cannot update firewall; do not know current netconfig. Run "ubos-admin setnetconfig" once``
    and you should do exactly that. For example, if your network configuration is ``client``,
    run ``ubos-admin setnetconfig client``.

    You only need to do this once. But once you have, it allows UBOS to automatically open
    ports in the UBOS firewall when an app is installed that needs to open a non-standard port,
    something that was not possible before.

* Apps:

  * The Bitcoin, Ethereum and Monero cryptocurrency daemons are now available in the
    UBOS repositories and can be run simply by executing ``pacman -S`` (for installation)
    and ``systemctl start`` (to start running). Note: these are the backends only, UBOS
    does not currently ship wallets or other user-facing functionality (which you
    would likely want to run on a different device, like your phone or PC, anyway).

  * Dave Winer's River5 RSS "river-of-news" aggregator is now available. To install,
    invoke ``ubos-admin createsite`` and enter ``river`` (not ``river5``) as the name
    of the app.

  * Added the Wordpress plugin ``indieweb-press-this``.

  * Wordpress should not nag about available upgrades any more. This functionality does
    not make any sense on UBOS.

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

* We have further increased the number of tests we do before releasing UBOS. This should
  make it even less likely that UBOS upgrades fail.

