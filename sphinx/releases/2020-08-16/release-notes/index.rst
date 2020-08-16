Release Notes: UBOS update 2020-08-16
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

Note: You may receive a message that says "Failed to refresh some expired keys".
This is harmless and you can ignore it.

What's new
----------

New platforms
^^^^^^^^^^^^^

* The Raspberry Pi 4 is now supported, and the documentation has been updated with
  instructions for how to install UBOS on it.

New features
^^^^^^^^^^^^

* App Nextcloud can now use ftp servers and SMB network drives as external storage.
* App Nextcloud's maximum memory and maximum upload size can now be easily configured.
  By default, each are 512MB, but you can set different values right in your Site JSON file.
  For an existing Site, export the Site JSON file with ``sudo ubos-admin showsite --json``,
  look for the new customization points, change the values there, and redeploy with
  ``sudo ubos-admin deploy --file ...``.
* Accessories required by other Accessories deployed at the same AppConfiguration are now
  deployed automatically. This often makes life easier when running commands such as
  ``ubos-admin createsite`` because UBOS will automatically figure out what other Accessories
  are required and deploy them without further ado.
* ``ubos-admin status`` can now be run while other commands are running. This is useful
  for troubleshooting.
* Easier to copy-paste site administrator passwords from the UBOS Staff: there is a new
  icon, and it can be used without displaying the password on screen.
* ``ubos-admin listsites --with-installable`` allows you to just list those sites on a
  device that have a certain App or Accessory installed.
* ``ubos-admin status`` now can also show snapper snapshot information

Other improvements
^^^^^^^^^^^^^^^^^^

* If there is only one Site on a device, ``ubos-admin showsite`` does not require you
  to specify its identifier or hostname.
* ``sudo ubos-admin setup-shepherd``, when invoked without arguments, sets up a
  shepherd account with a newly generated SSH key pair.
* Letsencrypt has gained a logrotate file, to avoid endless log files
* ``ubos-admin status`` now has exit code 1 if there are problems, for easier scripting.
* The HTML saved to the UBOS Staff now has a note if it was saved when no network was
  available. In this case, no hyperlinks will be generated either.
* Processes on the UBOS device can now connect to localhost via IPv6.
* ``ubos-admin showsite`` no longer shows internal customizationpoints. They are also
  not displayed in the HTML generated on the UBOS Staff any more.
* Webfinger support now always uses utf-8.
* Restoring sites from backup, and during upgrades, has become faster when there are
  many files to restore.
* Values for new customizationpoints are automatically added during upgrades.
* ``ubos-admin createsite`` does not exit any more when a package is specified as an
  App or Accessory that isn't actually one.
* ``ubos-install`` performs more checking for potential issues before attempting to
  install.
* Better error messages, progress messages and sanity checks.


Bug fixes
^^^^^^^^^

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-22``.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
