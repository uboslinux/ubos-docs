Release Notes: UBOS update 2020-02-17
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

New features
^^^^^^^^^^^^

* System logs are now written onto the UBOS Staff when booted while it is present. This
  makes troubleshooting of issues on devices that don't have an associated keyboard or
  monitor much simpler.

* UBOS now knows how to handle major Postgres updates automatically.

* The Storj decentralized storage platform is now available on the UBOS "yellow"
  release channel. Storj provides functionality similar to Amazon Web Services' S3,
  but instead of sending your data to somebody else's cloud, Storj breaks it down into
  small, encrypted pieces and stores them on computers owned by users like you. You can
  also offer part of your own disk to other users, all at prices that are lowed than
  S3. For details, see the
  :doc:`UBOS documentation on Storj <../../../users/howto-storj>`. (Feedback
  appreciated!)

Notable new packages:
^^^^^^^^^^^^^^^^^^^^^

* Arduino command-line tools
* Platform.io command-line tools

Package upgrades:
^^^^^^^^^^^^^^^^^

Over 600 packages were upgraded.

Bug fixes
^^^^^^^^^

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-21``.

Known problems
--------------

If you receive a message about “unknown trust” when installing a package or updating
your system, see
`this FAQ <../../../users/troubleshooting.html#installing-a-new-package-or-upgrading-fails-with-a-message-about-unknown-trust>`_.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
