Beta 3 Release Notes
====================

New features
------------

* **Major:** Support for ARM v7, in addition to ARM v6 and x86 (64bit). First supported devices on
  ARM v7 are the `Raspberry Pi 2 <http://www.raspberrypi.org/products/raspberry-pi-2-model-b/>`_ ,
  and the `Beagle Bone Black <http://beagleboard.org/black>`_.

* **Major:** The UBOS staff for easy, secure device configuration without needing a keyboard or monitor.
  See `blog post <http://upon2020.com/blog/2015/03/ubos-shepherd-rules-their-iot-device-flock-with-a-staff>`_
  and :doc:`/users/shepherd-staff`.

* Use hardware random generators where available on the device. This increases security and
  substantially reduces the time from first boot until the device is fully running on Raspberry
  Pi, Raspberry Pi 2, and Beagle Bone Black
  (`ubos-admin issue 32 <https://github.com/uboslinux/ubos-admin/issues/32>`_ and
  `ubos-admin issue 57 <https://github.com/uboslinux/ubos-admin/issues/57>`_). On VirtualBox, ``haveged`` is
  used to keep random generation times down.

* Shrink size of the image. This is accomplished by not installing certain pages (like man
  pages) by default, which also improves boot times
  (`ubos-admin issue 35 <https://github.com/uboslinux/ubos-admin/issues/35>`_ and
  `ubos-admin issue 30 <https://github.com/uboslinux/ubos-admin/issues/30>`_)

* ``ubos-admin createsite`` can now save the generated
  :doc:`/developers/site-json` to a file
  (`ubos-admin issue 40 <https://github.com/uboslinux/ubos-admin/issues/40>`_)

* There is progress output during lengthy ``ubos-admin createsite`` operations
  (`ubos-admin issue 47 <https://github.com/uboslinux/ubos-admin/issues/47>`_)


Bug fixes
---------

* ``cloud-init`` has been removed, so no more pesky console output
  (`ubos-admin issue 22 <https://github.com/uboslinux/ubos-admin/issues/22>`_)

* Do not accept really bad passwords
  (`ubos-admin issue 33 <https://github.com/uboslinux/ubos-admin/issues/33>`_)

* HTTP access log now contains virtual host
  (`ubos-admin issue 34 <https://github.com/uboslinux/ubos-admin/issues/34>`_)

* Removed spurious Site JSON fields
  (`ubos-admin issue 39 <https://github.com/uboslinux/ubos-admin/issues/39>`_)

* Improved robustment in the face of various error conditions
  (`ubos-admin issue 41 <https://github.com/uboslinux/ubos-admin/issues/41>`_ and
  `ubos-admin issue 58 <https://github.com/uboslinux/ubos-admin/issues/58>`_)

* Fixes related to TLS-enabled wildcard sites
  (`ubos-admin issue 42 <https://github.com/uboslinux/ubos-admin/issues/42>`_ and
  `ubos-admin issue 62 <https://github.com/uboslinux/ubos-admin/issues/62>`_)

* Remove installation bash history
  (`ubos-admin issue 46 <https://github.com/uboslinux/ubos-admin/issues/46>`_)

* Fixed redeployment of wildcard :term:`Site` to named hostname
  (`ubos-admin issue 48 <https://github.com/uboslinux/ubos-admin/issues/48>`_)

* Over-aggressive validity checking for accessories
  (`ubos-admin issue 49 <https://github.com/uboslinux/ubos-admin/issues/49>`_)

* Incorrectly shown ``http`` for ``https`` site
  (`ubos-admin issue 55 <https://github.com/uboslinux/ubos-admin/issues/55">`_)

New packages
------------

* zip tools

Known issues
------------
* Some sections in the documentation are still placeholders
  (`several doc issues <https://github.com/uboslinux/ubos-docs/issues>`_)

* ``haveged`` should be pre-installed and pre-configured, but not enabled on
  all devices, so users have the option to accelerate random number generation
  even before the network is up. This leads to long boot times on headless
  x86 PCs at this time
  (`macrobuild-ubos issue 11 <https://github.com/uboslinux/macrobuild-ubos/issues/11>`_)

* Wildcard sites incorrectly redirect to https when TLS is used
  (`ubos-admin issue 42 <https://github.com/uboslinux/ubos-admin/issues/42>`_)

* Some incorrect configurations related to multiple apps at the same virtual
  host are not detected
  (`ubos-admin issue 64 <https://github.com/uboslinux/ubos-admin/issues/64>`_ and
  `ubos-admin issue 63 <https://github.com/uboslinux/ubos-admin/issues/63>`_)

* Selfoss does not initialize on self-signed TLS site
  (`ubos-selfoss issue 2 <https://github.com/uboslinux/ubos-selfoss/issues/2>`_)

* Toy app ``gladiwashere-java`` cannot run on wildcard host
  (`ubos-toyapps issue 4 <https://github.com/uboslinux/ubos-toyapps/issues/4>`_)

`Last updated: 2015-03-12 16:30 PST` with small formatting edits `2016-08-15 17:30 PST`.
