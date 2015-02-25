``ubos-admin undeploy``
=======================

See also :doc:`../../users/ubos-admin`.

Assuming the site to be undeployed exists, UBOS will perform the following steps:

#. The site will be suspended, and the frontpage will be replaced with a "site not found"
   message.

#. All apps and accessories at the site will be undeployed.
   For each of them, the :doc:`manifest JSONs <../ubos-manifest>`
   is processed for each of the roles, and each of the AppConfigurationItems
   is undeployed: files are deleted, directories deleted recursively, databases
   unprovisioned, and scripts run. The AppConfigurationItems will be processed in
   reverse sequence than during deployment.

#. All data of all the apps and accessories installed at the site will be discarded.
   Depending on the apps, this may include the deletion of uploaded files, and the
   "drop" of databases.
