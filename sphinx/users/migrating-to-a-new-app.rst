Migrating from one app to another
=================================

Motivation
----------

Sometimes, an app gets forked, as it happened recently with ownCloud and its new
fork Nextcloud. Sometimes, a developer would make it particularly easy to let users
take their data from an old app and use it in their new app. Sometimes, major versions
of apps are sufficiently different from each other that in UBOS, we effectively treat
them as different apps (such as Nextcloud 9 and Nextcloud 10).

Under any of these circumstances, the user needs to be able to tell UBOS to migrate
their data and configuration to a new app.

How to migrate from one app to another
--------------------------------------

For simplicity, let's assume that a device only runs a single site, and at that site,
a single app is installed that needs to be migrated to another app. Let's assume that
the site has hostname ``example.com``. In case of more complex setups, different options
to the backup and restore commands should be used (e.g. only some sites instead of all),
otherwise everything is the same.

Let's take a real-world example, and assume you want to upgrade from ``nextcloud9`` to
``nextcloud10``.

1. Create a backup of the existing site, such as::

      ubos-admin backup --host example.com --out before-migration.ubos-backup

2. Undeploy the site, such as::

      ubos-admin undeploy --host example.com

3. Restore the backup, instructing UBOS to swap out ``nextcloud9`` and replace it with
   ``nextcloud10``::

      ubos-admin restore --in before-migration.ubos-backup --migratefrom nextcloud9 --migrateto nextcloud10

This will restore your site into the same location (hostname, context path), restore and
migrate all your data, but run ``nextcloud10`` going forward instead of ``nextcloud9``.

And if it didn't work? (It should!) Then simply undeploy the new site, and restore from
the backup without replacing the app. Also, `tell us <http://ubos.net/community/>`_ about it
so we can fix what needs fixing.

Currently supported migrations
------------------------------

This only works if the new app was packaged in a way that it actually knows how
to import some other app's data. Currently, the following migrations are supported:

 * from ``owncloud`` to ``nextcloud9``
 * from ``nextcloud9`` to ``nextcloud10``

Attempting migration for any other combination of apps will have unpredictable (and
probably bad) results.


