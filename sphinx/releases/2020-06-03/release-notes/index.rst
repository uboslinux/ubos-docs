Release Notes: Apps update 2020-06-03
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

Major package upgrades in this version
--------------------------------------

* Matomo

* Nextcloud and many Nextcloud accessories

* MediaWiki

* Webtrees

* WordPress and many WordPress accessories

Documentation
-------------

Common use cases for modifying deployed Sites are now described
:doc:`here <../../../users/howto-modifysite>`.

Known issues
------------

If you are running Wordpress with a theme that is not bundled by default any more in
recent releases, Wordpress may come up blank after the upgrade. To fix, log into Wordpress
from the browser (at relative URL ``/wp-admin``) and select a different theme. Or add
your old theme into your Site JSON as an explicit accessory.

Bug fixes
---------

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-apps-22``.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
