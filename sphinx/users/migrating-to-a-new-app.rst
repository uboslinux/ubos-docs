Migrating from one App to another
=================================

Motivation
----------

Sometimes, an :term:`App` gets forked, as it happened recently with ownCloud and its new
fork Nextcloud. Sometimes, a developer would make it particularly easy to let users
take their data from an old :term:`App` and use it in their new :term:`App`. Sometimes, major versions
of :term:`Apps <App>` are sufficiently different from each other that in UBOS, we effectively treat
them as different :term:`Apps <App>` (such as Nextcloud 9 and Nextcloud 10).

Under any of these circumstances, the user needs to be able to tell UBOS to migrate
their data and configuration to a new :term:`App`.

How to migrate from one App to another
--------------------------------------

For simplicity, let's assume that a device only runs a single :term:`Site`, and at that :term:`Site`,
a single :term:`App` is installed that needs to be migrated to another :term:`App`. Let's assume that
the :term:`Site` has hostname ``example.com``. In case of more complex setups, different options
to the backup and restore commands should be used (e.g. only some :term:`Sites <Site>` instead of all),
otherwise everything is the same.

Let's take a real-world example, and assume you want to upgrade from ``nextcloud9`` to
``nextcloud10``.

#. Create a backup of the existing :term:`Site`, such as:

   .. code-block:: none

      % sudo ubos-admin backup --host example.com --out before-migration.ubos-backup

#. Undeploy the :term:`Site`, such as:

   .. code-block:: none

      % sudo ubos-admin undeploy --host example.com

#. Restore the backup, instructing UBOS to swap out ``nextcloud9`` and replace it with
   ``nextcloud10``:

   .. code-block:: none

      % ubos-admin restore --in before-migration.ubos-backup --migratefrom nextcloud9 --migrateto nextcloud10

This will restore your :term:`Site` into the same location (hostname, context path), restore and
migrate all your data, but run ``nextcloud10`` going forward instead of ``nextcloud9``.

And if it didn't work? (It should!) Then simply undeploy the new :term:`Site`, and restore from
the backup without replacing the :term:`App`. Also, `tell us </community/>`_ about it
so we can fix what needs fixing.

