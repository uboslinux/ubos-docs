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
  (`issue <https://github.com/uboslinux/ubos-admin/issues/32>`_ and
  `issue <https://github.com/uboslinux/ubos-admin/issues/57>`_). On VirtualBox, ``haveged`` is
  used to keep random generation times down.

* Shrink size of the image. This is accomplished by not installing certain pages (like man
  pages) by default, which also improves boot times
  (`issue <https://github.com/uboslinux/ubos-admin/issues/35>`_ and
  `issue <https://github.com/uboslinux/ubos-admin/issues/30>`_)

* ``ubos-admin createsite`` can now save the generated
  :doc:`/developers/site-json` to a file
  (`issue <https://github.com/uboslinux/ubos-admin/issues/40>`_)

* There is progress output during lengthy ``ubos-admin createsite`` operations
  (`issue <https://github.com/uboslinux/ubos-admin/issues/47>`_)


Bug fixes
---------

* ``cloud-init`` has been removed, so no more pesky console output
  (`issue <https://github.com/uboslinux/ubos-admin/issues/22>`_)

* Do not accept really bad passwords
  (`issue <https://github.com/uboslinux/ubos-admin/issues/33>`_)

* HTTP access log now contains virtual host
  (`issue <https://github.com/uboslinux/ubos-admin/issues/34>`_)

* Removed spurious Site JSON fields
  (`issue <https://github.com/uboslinux/ubos-admin/issues/39>`_)

* Improved robustment in the face of various error conditions
  (`issue <https://github.com/uboslinux/ubos-admin/issues/41>`_ and
  `issue <https://github.com/uboslinux/ubos-admin/issues/58>`_)

* Fixes related to TLS-enabled wildcard sites
  (`issue <https://github.com/uboslinux/ubos-admin/issues/42>`_ and
  `issue <https://github.com/uboslinux/ubos-admin/issues/62>`_)

* Remove installation bash history
  (`issue <https://github.com/uboslinux/ubos-admin/issues/46>`_)

* Fixed redeployment of wildcard site to named hostname
  (`issue <https://github.com/uboslinux/ubos-admin/issues/48>`_)

* Over-aggressive validity checking for accessories
  (`issue <https://github.com/uboslinux/ubos-admin/issues/49>`_)

* Incorrectly shown ``http`` for ``https`` site
  (`issue <https://github.com/uboslinux/ubos-admin/issues/55">`_)

New packages
------------

* zip tools

Known issues
------------
* Some sections in the documentation are still placeholders
  (`several issues <https://github.com/uboslinux/ubos-docs/issues>`_)

* ``haveged`` should be pre-installed and pre-configured, but not enabled on
  all devices, so users have the option to accelerate random number generation
  even before the network is up. This leads to long boot times on headless
  x86 PCs at this time
  (`issue <https://github.com/uboslinux/macrobuild-ubos/issues/11>`_)

* Wildcard sites incorrectly redirect to https when TLS is used
  (`issue <https://github.com/uboslinux/ubos-admin/issues/42>`_)

* Some incorrect configurations related to multiple apps at the same virtual
  host are not detected
  (`issue <https://github.com/uboslinux/ubos-admin/issues/64>`_ and
  `issue <https://github.com/uboslinux/ubos-admin/issues/63>`_)

* Selfoss does not initialize on self-signed TLS site
  (`issue <https://github.com/uboslinux/ubos-selfoss/issues/2>`_)

* Toy app ``gladiwashere-java`` cannot run on wildcard host
  (`issue <https://github.com/uboslinux/ubos-toyapps/issues/4>`_)

`Last updated: 2015-03-12 16:30 PST`
