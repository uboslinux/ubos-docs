Release Notes: Apps update 2019-11-12
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

Package upgrades:
^^^^^^^^^^^^^^^^^

* Matomo has been upgraded to 3.12.0

* Mattermost has been upgraded to 5.15.2

* Mediawiki has been upgraded to 1.33.1

* Nextcloud has been upgraded to 17.0.1. Also, the following accessories were upgraded or
  newly added:

  * ``nextcloud-audioplayer``
  * ``nextcloud-bookmarks``
  * ``nextcloud-cache-redis``
  * ``nextcloud-calendar``
  * ``nextcloud-contacts``
  * ``nextcloud-deck``
  * ``nextcloud-files-rightclick``
  * ``nextcloud-group-everyone``
  * ``nextcloud-groupfolders``
  * ``nextcloud-mail``
  * ``nextcloud-markdown``
  * ``nextcloud-news``
  * ``nextcloud-notes``
  * ``nextcloud-onlyoffice``
  * ``nextcloud-passwords``
  * ``nextcloud-social``
  * ``nextcloud-socialsharing-email``
  * ``nextcloud-socialsharing-facebook``
  * ``nextcloud-socialsharing-twitter``
  * ``nextcloud-spreed``
  * ``nextcloud-tasks``
  * ``nextcloud-text``
  * ``nextcloud-twofactor-totp``

* The package ``nextcloud16`` was added. ``nextcloud15`` was upgraded.

* Shaarli has been upgraded to 0.11.1

* Wordpress has been upgraded to 5.2.4. Also, the following accessories were upgraded or
  newly added:

  * ``wordpress-plugin-classic-editor``
  * ``wordpress-plugin-google-analytics-for-wordpress``
  * ``wordpress-plugin-indieauth``
  * ``wordpress-plugin-indieweb-post-kinds``
  * ``wordpress-plugin-semantic-linkbacks``
  * ``wordpress-plugin-seo``
  * ``wordpress-plugin-simple-location``
  * ``wordpress-plugin-social-networks-auto-poster-facebook-twitter-g``
  * ``wordpress-plugin-webmention``
  * ``wordpress-plugin-wp-mail-smtp``
  * ``wordpress-theme-responsive``

New features
^^^^^^^^^^^^

Those apps that may send e-mail now automatically activate a local, outgoing e-mail server
(``postfix``). However, you may need to work around your internet service provider to
actually get mail out from your home network: see our `notes on Amazonses </docs/users/apps/amazonses.html>`_.

Bug fixes
^^^^^^^^^

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-apps-20``.

Known problems
--------------

In one instance, a Matomo upgrade failed with ``Error in Matomo: Mysqli prepare error:
Access denied for user ... to database ...``. This problem goes away if the Goals plugin
is disabled (go to Administration / System / Plugins).


Note on skipped Nextcloud major version upgrades
------------------------------------------------

If you have not upgraded your UBOS device running Nextcloud for a while, the Nextcloud
upgrader may not be able to upgrade your installation in one go. As a workaround, we have
introduced packages ``nextcloud16`` and ``nextcloud15``, which contain Nextcloud version
16 and 15, respectively. You can use these packages as an intermediate step to upgrade
from an earlier Nextcloud to the current version. This is described in more detail in
:doc:`/users/apps/nextcloud`.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
