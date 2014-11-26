``ubos-admin undeploy``
=======================

To undeploy an existing site, invoke::

   > sudo ubos-admin undeploy --siteid <siteid>

or::

   > sudo ubos-admin undeploy --host <hostname>

Assuming the specified site exists, UBOS will perform the following steps:

#. The site will be suspended, and the frontpage will be replaced with a "site not found"
   message.

#. All apps and accessories at the site will be undeployed.
   For each of them, the :doc:`manifest JSONs </developers/ubos-manifest>`_
   is processed for each of the roles, and each of the AppConfigurationItems
   is undeployed: files are deleted, directories deleted recursively, databases
   unprovisioned, and scripts run.

#. All data of all the apps and accessories installed at the site will be discarded.
   Depending on the apps, this may include the deletion of uploaded files, and the
   "drop" of databases.

.. warning:: Undeploying a site is like ``rm -f``. All the data at the site will be lost.
   To retain the data, first run ``ubos-admin backup`` (see :doc:`backup`)

