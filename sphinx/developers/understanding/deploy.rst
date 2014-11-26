``ubos-admin deploy``
=====================

To deploy a new site, or redeploy an existing site with an updated configuration,
invoke::

   > sudo ubos-admin deploy --file <site.json>

This requires a :term:`Site JSON` file that defines the configuration of the site.

The simplest way of creating a Site JSON file is to invoke::

   > sudo ubos-admin createsite -n

and to answer the questions on the console. By adding the ``-n`` options to the command,
``ubos-admin createsite`` will not actually create the site, but only emit the Site JSON
for the site. (Leaving out the ``-n`` will not emit the JSON, but invoke
``ubos-admin deploy`` automatically)

If the Site JSON file is valid, UBOS will perform the following steps:

#. Install required packages that haven't been installed yet. This includes:

   * the packages of apps to be deployed per the the Site JSON, but not yet
     installed on the device;
   * the packages of accessories to be deployed per the Site JSON, but not yet
     installed on the device;
   * dependencies of those packages as listed in the respective ``PKGBUILD``
     files;
   * packages listed in the ``depends`` section of the
     :doc:`manifest JSONs </developers/ubos-manifest>`_ of the
     apps and accessories, for those roles that are being used on the device.

#. If the site has previously been deployed, the site will be suspended, and
   the data of all the apps and accessories at the site will temporarily be backed up.

#. The frontpage will be replaced with a placeholder saying "upgrade in progress".

#. If the site has previously been deployed, all apps and accessories at the
   deployed site will be undeployed.

#. All the apps and the accessories in the new Site JSON will be deployed.
   For each of them, the :doc:`manifest JSONs </developers/ubos-manifest>`_
   is processed for each of the roles, and each of the AppConfigurationItems
   is deployed: files are copied, directories created, databases provisioned
   and populated, and scripts run.

#. If an app at the site was previously deployed, the previously backed-up
   data will be restored, and the "upgrade" scripts will be run that were
   specified by the app and any accessories.

#. If an app at the site was not previously deployed, the "installer" scripts
   will be run that were specified by the app and any accessories.

#. The frontpage of the site will be re-enabled.

