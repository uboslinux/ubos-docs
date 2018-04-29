Beta 14 Release Notes
=====================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file:

* ``sudo ubos-admin backup --out ~/XXX.ubos-backup``

Then, update your device without automatic reboot:

* ``sudo ubos-admin update --noreboot``

And then perform a manual reboot:

* ``sudo systemctl reboot``


What's new: for users
---------------------

* App data has moved to a new directory tree ``/ubos``, which on a freshly installed system
  is initially empty. That makes it much easier to use UBOS with a large "data" disk because
  the boot disk does not need to be expanded for the extra data.

* ``ubos-admin createsite`` now accepts an optional argument ``--from-template <file>``,
  where ``<file>`` is a Site JSON file from which some information is missing. The command
  will then only ask the user for the missing information. This allows the distribution of
  Site JSON template files that configure a complex site with multiple applications and
  customization points, where users only have to fill in what's unique to them (such as
  their site admin credentials) and are ready to go.

* New command ``ubos-admin shownetconfig`` displays information about the most recently
  set network configuration.

* The ``ubos-admin`` subcommands ``deploy``, ``undeploy``, and ``update`` now accept
  an optional argument ``--backup <file>``. This will create a backup of the
  affected site(s) to the specified file prior to the respective operation. This is a
  convenience method for the user, as it's generally good practice to create backups
  prior to operations such as these that modify or delete data. It also reduces site
  downtime because sites have to be suspended only once for both backup and the operation.

* UBOS now requires SD cards for installation that are at least 8GB large (from 4GB).

* Various other improvements and bug fixes.

What's new: for developers
--------------------------

* Some directories have changed. Going forward, put application code into
  ``/ubos/share/<package>/`` (previously: ``/usr/share/<package>/``), manifests into
  ``/ubos/lib/ubos/manifests/`` (previously: ``/var/lib/ubos/manifests/``) and
  data files into ``/ubos/lib/<package>/`` (previously: ``/var/lib/<package>/``). The
  pre-defined constants like ``${appconfig.apache2.dir}`` have been updated.

* New AppConfigurationItem ``exec`` executes arbitrary programs, passing parameters as a JSON
  file. This allows developers to avoid writing wrappers in Perl. AppConfigurationItem
  ``perlscript`` continues to be available with the same invocation as before.

* New AppConfigurationItem ``systemd-target`` joins ``systemd-service`` and ``systemd-timer``
  and works in the way you'd expect.

* AppConfigurationItem ``symlink`` now is permitted to point to non-existing files.

