Beta 11 Release Notes
=====================

For users
---------

* New features:

  * The Marvell ESPRESSObin is now a supported UBOS device. It features three Ethernet
    ports and a SATA connector.

  * `smartctld` is now running by default. It continues checking the health of your
    attached disks. It currently does not automatically take action yet, but if you
    like, you can edit its config file and make it send you e-mail. You can also
    occasionally invoke `smartctl` to manually pull up the reports.

* Major app upgrades:

  * Nextcloud 12

  * The following Nextcloud apps have been added: Calendar, Contacts, Mail, News, Notes,
    Spreed, Tasks

  * Selfoss 2.17

  * Wordpress 4.8

* Hundreds of upgraded packages.

* Major bug fixes:

* All images for all platforms have been updated.

For developers
--------------

* You can now deploy Python / Django applications on UBOS.

* `ubos-push` can now take alternate ssh key

* `nmap` has been added

* The Apache web server configuration can now utilize TLS certificate revocations

Known issues
------------

* When you upgrade from an existing UBOS installation, upgrade may fail with this error
  message:

  .. code-block:: none

     ca-certificates-utils: /etc/ssl/certs/ca-certificates.crt exists in filesystem
     Errors occurred, no packages were upgraded.

  If that occurs, delete that file manually (``sudo rm /etc/ssl/certs/ca-certificates.crt``)
  and run the upgrade again.

* Mattermost requires the user invoke ``ubos-admin setnetconfig`` after install. This
  is because Mattermost opens up a non-standard port, and UBOS currently only reconfigures
  its firewall when ``ubos-admin setnetconfig`` is invoked.

* When running UBOS in a VirtualBox virtual machine, and using the (default) Intel Pro/1000
  MT Desktop (82540EM) virtual ethernet interface, UBOS may not be able to obtain a
  network connection, and messages containing "Reset adapter" may be continuously
  written the control. To avoid this, shut down the virtual machine, and from the
  VirtualBox toolbar select "Machine", then "Settings", click on the "Network" tab.
  For the active "Adapter 1", click on "Advanced" and select Adapter Type
  "PCnet-PCI II". Click "OK" and start the virtual machine again.

* The original Raspberry Pi 1 may time out when attempting to set up a Tor site, and
  not complete the setup.  We are currently considering to end-of-life this device.
  The other Raspberry Pi's will not be affected.

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads for it than for other devices.

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.
