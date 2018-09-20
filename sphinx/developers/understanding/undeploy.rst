``ubos-admin undeploy``
=======================

See also :doc:`../../users/ubos-admin`.

Assuming the :term:`Site` to be undeployed exists, UBOS will perform the following steps:

#. The :term:`Site` will be suspended, and the frontpage will be replaced with a
   "site not found" message.

#. All :term:`Apps <App>` and :term:`Accessories <Accessory>` at the :term:`Site` will be
   undeployed. For each of them, the :doc:`manifest JSONs <../ubos-manifest>`
   is processed for each of the roles, and each of the :term:`AppConfigItems <AppConfigItem>`
   is undeployed: files are deleted, directories deleted recursively, databases
   unprovisioned, and scripts run. The :term:`AppConfigItems <AppConfigItem>` will be
   processed in reverse sequence than during deployment.

#. If a backup was requested, the backup will be created.

#. All data of all the :term:`Apps <App>` and :term:`Accessories <Accessory>` installed at
   the :term:`Site` will be discarded. Depending on the :term:`Apps <App>`, this may
   include the deletion of uploaded files, and the "drop" of databases.

This command must be run as root (``sudo ubos-admin undeploy``).
