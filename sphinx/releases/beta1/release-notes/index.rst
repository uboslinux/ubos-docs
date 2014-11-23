Beta 1 Release Notes
====================

As behooves a beta 1, there are some known issues.

General
-------

* Invoking ``ubos-admin`` more than once simultaneously may have unpredictable
  results. See `this issue <https://github.com/indiebox/ubos-admin/issues/19>`_.

* Backups always contain key material. See
  `this issue <https://github.com/indiebox/ubos-admin/issues/13>`_.

* There is currently no command that can show which apps and accessories are available
  for install. See `this issue <https://github.com/indiebox/ubos-admin/issues/11>`_.
  For now, refer to this `blog post <http://ubos.net/blog/2014/11/20/ubos-beta1-available/>`_.

* Need more ``ubos-admin`` sub-commands to modify existing sites and to create SSL sites.
  Note: you can always use ``ubos-admin deploy`` and ``ubos-admin undeploy`` directly.
  See issues `here <https://github.com/indiebox/ubos-admin/issues/10>`_,
  `here <https://github.com/indiebox/ubos-admin/issues/8>`_ and
  `here <https://github.com/indiebox/ubos-admin/issues/6>`_.

* Some sections in the documentation are still placeholders. See
  `documentation issues <https://github.com/indiebox/ubos-docs/issues>`_.

x86-specific
------------

* The grub bootloader reports the operating system as "Arch", not "UBOS".
  See `this issue <https://github.com/indiebox/macrobuild-ubos/issues/2>`_.

* UBOS currently misses some tools to install UBOS on a hard drive after booting from
  a USB stick. See `this issue <https://github.com/indiebox/ubos-buildconfig/issues/1>`_.

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
  DNS name must be used. See `this issue <https://github.com/indiebox/ubos-owncloud/issues/1>`_.

`Last updated: 2014-11-21 16:30 PST`

