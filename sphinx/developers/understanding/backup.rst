``ubos-admin backup``
=====================

See also :doc:`../../users/ubos-admin`.

There are many variations of this command. Regardless of which variation of the command is
used, UBOS generally performs the following actions:

* It suspends the site(s) affected by the backup, and temporarily replaces them with a
  placeholder page.

* For each of the apps and accessories affected by the backup, UBOS will examine the
  corresponding :doc:`/developers/ubos-manifest` and look for AppConfigurationItems that
  have the following fields:

  .. code-block:: json

     "retentionpolicy" : "keep",
     "retentionbucket" : "name"

  Each of the AppConfigurationItems with these two fields will be backed up. All other
  AppConfiguration items will be ignored for the purposes of backup.

* The actual backup performed depends on the type of AppConfigurationItem. For example,
  a MySQL database will be dumped, and the resulting dump will be backed up.

* The individually exported items, and certain meta-data are assembled in a
  :doc:`/developers/ubos-backup` file.

* UBOS resumes the site(s) and removes the placeholder page.

See also: :doc:`restore`.
