Beta 1 Release Notes
====================

As behooves a beta 1, there are some known issues.

General
-------

* Invoking ``ubos-admin`` more than once simultaneously may have unpredictable
  results. See https://github.com/uboslinux/ubos-admin/issues/19.

* Backups always contain key material. See
  https://github.com/uboslinux/ubos-admin/issues/13.

* There is currently no command that can show which apps and accessories are available
  for install. See https://github.com/uboslinux/ubos-admin/issues/11.
  For now, refer to the
  `UBOS Beta 1 available blog post <http://ubos.net/blog/2014/11/20/ubos-beta1-available/>`_.

* Need more ``ubos-admin`` sub-commands to modify existing sites and to create SSL sites.
  Note: you can always use ``ubos-admin deploy`` and ``ubos-admin undeploy`` directly.
  See issues https://github.com/uboslinux/ubos-admin/issues/10,
  https://github.com/uboslinux/ubos-admin/issues/8 and
  https://github.com/uboslinux/ubos-admin/issues/6.

* Some sections in the documentation are still placeholders. See
  documentation issues https://github.com/uboslinux/ubos-docs/issues.

x86-specific
------------

* The grub bootloader reports the operating system as "Arch", not "UBOS".
  See https://github.com/uboslinux/macrobuild-ubos/issues/2.

* UBOS currently misses some tools to install UBOS on a hard drive after booting from
  a USB stick. See https://github.com/uboslinux/ubos-buildconfig/issues/1.

* Added: ``cloud-init`` produces many messages (including apparent errors and warnings)
  on the console. These are harmless, but annoying. See
  https://github.com/uboslinux/ubos-admin/issues/22.

Raspberry Pi-specific
---------------------

* UBOS may take some time before it is ready to be used after the first boot. The
  Raspberry Pi is not very fast, and UBOS needs to generate a number of cryptographic
  keys before it is ready. To check status, execute:

  .. code-block:: none

     systemctl is-system-running

If you execute ``ubos-admin`` before UBOS is ready, it will ask you to try again later.

Specific to particular applications
-----------------------------------

* ownCloud must not be installed at the wildcard ("``*``") host; instead, an valid
  DNS name must be used. See https://github.com/uboslinux/ubos-owncloud/issues/1.

`Last updated: 2014-12-08 10:30 PST`

