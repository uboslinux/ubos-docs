Release Notes: Apps update 2020-08-04
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

Note: You may receive a message that says "Failed to refresh some expired keys".
This is harmless and you can ignore it.

New packages in this version
----------------------------

* The Collabora Online "app" is now available for Nextcloud. When creating the Site,
  you need to add ``nextcloud-richdocuments`` and ``nextcloud-richdocumentscode``
  as Accessories.

* The Nextcloud forms app is now available. Add ``nextcloud-forms`` to your list
  of Accessories.

Major package upgrades in this version
--------------------------------------

* Matomo now at 3.14.0

* MediaWiki now at 1.34.2

* Nextcloud and many Nextcloud accessories. Nextcloud is now at version 19.0.1.

* Webtrees now at 2.0.7

* WordPress and many WordPress accessories. WordPress is now at version 5.4.2.

Bug fixes
---------

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-apps-23``.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
