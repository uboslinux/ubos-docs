Release Notes: Update 2019-04-02
================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

Notable new packages:
^^^^^^^^^^^^^^^^^^^^^

Several new Nextcloud "apps" are now available on UBOS:

* ``nextcloud-bruteforcesettings``: protect Nextcloud servers from attempts to guess user
  passwords in various ways
* ``nextcloud-deck``: kanban style organization tool aimed at personal planning and project
  organization for teams integrated with Nextcloud
* ``nextcloud-files-rightclick``: allows users and developers to have a right click menu
* ``nextcloud-group-everyone``: adds a virtual "Everyone" group.
* ``nextcloud-groupfolders``: admin configured folders shared by everyone in a group
* ``nextcloud-passwords``: allows you to store your passwords safely with Nextcloud
* ``nextcloud-socialsharing-email``: enable direct sharing of files via email, using shared links
* ``nextcloud-socialsharing-facebook``: enable direct sharing of files via Facebook, using shared links
* ``nextcloud-socialsharing-twitter``: enable direct sharing of files via Twitter, using shared links.

Package upgrades:
^^^^^^^^^^^^^^^^^

* ``nextcloud``
* ``nextcloud-bookmarks``
* ``nextcloud-contacts``
* ``nextcloud-news``
* ``nextcloud-onlyoffice``

There were 14 new or upgraded packages in total.

Fixes and improvements:
^^^^^^^^^^^^^^^^^^^^^^^

* Resolves a character-set issue sporadically producing errors in the Nextcloud user
  interface.

Known issues
------------

* ``ubos-admin status`` emits some (harmless) errors under some circumstances.

* Running Pagekite with ``ubos-admin start-pagekite`` on a device that runs a wildcard
  site (ie a site whose hostname was specified as ``*``) may not forward the traffic
  correctly. Redeploy the site with its public hostname instead.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
