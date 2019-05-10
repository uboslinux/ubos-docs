Release Notes: Update 2019-05-09
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

New functionality:
^^^^^^^^^^^^^^^^^^

* When redeploying a site that runs Nextcloud with a changed site administrator password,
  the site administrator password will be changed on the Nextcloud administrator account.
  This simplifies administrator password reset.

Package upgrades:
^^^^^^^^^^^^^^^^^

* Nextcloud has been upgraded to version 16. From the release notes: It "... introduces
  machine learning to detect suspicious logins and offering clever recommendations.
  Group Folders now sport access control lists so system administrators can easily manage
  who has access to what in organization-wide shares. There are also Projects, a way to
  easily relate and find related information like files, chats or tasks."

* The following Nextcloud accessories were upgraded:

  * ``nextcloud-bookmarks``
  * ``nextcloud-calendar``
  * ``nextcloud-contacts``
  * ``nextcloud-deck``
  * ``nextcloud-group-everyone``
  * ``nextcloud-groupfolders``
  * ``nextcloud-mail``
  * ``nextcloud-markdown``
  * ``nextcloud-news``
  * ``nextcloud-notes``
  * ``nextcloud-onlyoffice``
  * ``nextcloud-passwords``
  * ``nextcloud-spreed``

* ``mediawiki`` upgrade to 1.32.1, and corresponding ``mediawiki-ext-confirmaccount`` upgrade

* Minor ``decko`` upgrade

* Wordpress has been upgraded to version 5.1.1.

* The following Wordpress accessories were upgraded:

  * ``wordpress-plugin-google-analytics-for-wordpress``
  * ``wordpress-plugin-indieauth``
  * ``wordpress-plugin-indieweb-post-kinds``
  * ``wordpress-plugin-micropub``
  * ``wordpress-plugin-pterotype``
  * ``wordpress-plugin-seo``
  * ``wordpress-plugin-social-networks-auto-poster-facebook-twitter-g``
  * ``wordpress-plugin-syndication-links``
  * ``wordpress-plugin-wp-mail-smtp``

Fixes:
^^^^^^

* Removed duplicate ``Referer-Policy`` header for Nextcloud
* Added ``iconv`` dependency for Selfoss
* Added ``gd`` dependency for Shaarli
* Added files for some functionality in Webtrees

Known issues
------------

* ``ubos-admin status`` emits some (harmless) errors under some circumstances.

* Running Pagekite with ``ubos-admin start-pagekite`` on a device that runs a wildcard
  site (ie a site whose hostname was specified as ``*``) may not forward the traffic
  correctly. Redeploy the site with its public hostname instead.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
