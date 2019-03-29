Release Notes Update 2019-03-29
===============================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file:

* ``sudo ubos-admin backup --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

Package upgrades:
^^^^^^^^^^^^^^^^^

* Nextcloud
* Mastodon
* Wordpress
* Linux is now at kernel version 5.0.x (x86_64 only for now)
* Mariadb is now at 10.3.x
* Bitcoin daemon
* Ethereum daemon

There were several hundred package upgrades in total.

Notable new packages:
^^^^^^^^^^^^^^^^^^^^^

* Matomo, an analytics application (formerly named Piwik)
* The GNU debugger: gdb
* The PHP debugger: xdebug
* The Node version manager: nvm
* IPFS: go-ipfs
* More Wordpress plugins, such as Pterotype and SEO

Fixes and improvements:
^^^^^^^^^^^^^^^^^^^^^^^

* Various backup/restore issues were fixed. These had impacted primarily sites running
  Shaarli and Selfoss.
* Nextcloud installations now set the admin e-mail address automatically
* Nextcloud now shows memory info
* DNSSEC is turned off by default, as it appears to be incompatible with many deployed
  DNS servers that don't support it.

Changes for developers:
^^^^^^^^^^^^^^^^^^^^^^^

* Apps based on Node now need to package their own node runtime. More info is in
  the `documentation </docs-yellow/developers/middleware-notes/nodejs.html>`_.

Removed functionality
---------------------

* Mastodon has been (temporarily) removed from the ARM architectures.

Other
-----

* To find which issues have been closed as part of this release, search the
  `Github repos <https://github.com/uboslinux/>`_ for milestones
  ``ubos-18`` and ``ubos-apps-18``.

* The Personal Public License has had some clarifying edits. See
  `post </blog/2019/03/29/license-update.html>`_.

Known issues
------------

* ``ubos-admin status`` emits some (harmless) errors under some circumstances.

* Running Pagekite with ``ubos-admin start-pagekite`` on a device that runs a wildcard
  site (ie a site whose hostname was specified as ``*``) may not forward the traffic
  correctly. Redeploy the site with its public hostname instead.
