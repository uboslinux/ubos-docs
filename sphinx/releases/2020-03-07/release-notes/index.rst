Release Notes: Apps update 2020-03-07
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

Nextcloud Hub is now available natively on UBOS
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Like the collaboration features of Google Docs? But not the (lack of) privacy? The new
Nextcloud Hub now provides features very similar to Google Docs through an integration with
OnlyOffice, and you can run them on your UBOS device that you control. So you, and only
you, decide who gets to see your data.

Our friends at Nextcloud have `more details <https://nextcloud.com/hub/>`_ about
Nextcloud Hub. And on UBOS, you can install it with just a single command:

.. code-block:: none

   sudo ubos-admin createsite

Specify ``nextcloud`` as the app, and your selection of accessories, such as:
``nextcloud-cache-redis``, ``nextcloud-calendar``, ``nextcloud-contacts``,
``nextcloud-documentserver-community``, ``nextcloud-onlyoffice``, ``nextcloud-spreed``,
``nextcloud-text``.`

Available on ``x86_64`` only, not ARM (an OnlyOffice limitation).

Significant new functionality:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Nextcloud full-text search. Install accessories ``nextcloud-fulltextsearch``,
  ``nextcloud-files-fulltextsearch`` and ``nextcloud-fulltextsearch-elasticsearch``.

* Nextcloud real-time document editing (see above).

Package upgrades:
^^^^^^^^^^^^^^^^^

* Mastodon

* Matomo

* Mattermost

* Mediawiki, and accessories

* Nextcloud, and accessories, have a major new version

* phpBB

* Webtrees has a major new version

* Wordpress

Known issues
^^^^^^^^^^^^

If you run the Nextcloud OnlyOffice integration (accessory ``nextcloud-documentserver-community``),
you may receive message "ONLYOFFICE cannot be reached. Please contact admin". This is
because you accessed your Nextcloud through a hostname or IP address different from what
the Nextcloud installation expected.

To set the address at which the document server is available, go to the OnlyOffice
Settings in the Nextcloud user interface (as administrator, go to Settings, section Administration,
select ONLYOFFICE), and edit the Document Editing Service address. The URL there must start
with the same protocol, hostname and path as the URL you are using to access Nextcloud.

You may also need to set this the first time you access Nextcloud after initial deployment.

This has been filed as an issue with the Nextcloud project
`here <https://github.com/nextcloud/documentserver_community/issues/81>`_.

Bug fixes
^^^^^^^^^

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-apps-21``.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
