``ubos-admin deploy``
=====================

See also :doc:`../../users/ubos-admin`.

If the Site JSON file provided to this command is valid, UBOS will perform the following steps:

#. Install required packages that haven't been installed yet. This includes:

   * the packages of apps to be deployed per the the Site JSON, but not yet
     installed on the device;
   * the packages of accessories to be deployed per the Site JSON, but not yet
     installed on the device;
   * dependencies of those packages as listed in the respective ``PKGBUILD``
     files;
   * packages listed in the ``depends`` section of the
     :doc:`manifest JSONs <../ubos-manifest>` of the
     apps and accessories, for those roles that are being used on the device.
   * the database engine(s) required for the app, if not already installed.

#. If the site has previously been deployed, the site will be suspended, and
   the data of all the apps and accessories at the site will temporarily be backed up.

#. The frontpage will be replaced with a placeholder saying "upgrade in progress".

#. If the site has previously been deployed, all apps and accessories at the
   deployed site will be undeployed.

#. All the apps and the accessories in the new Site JSON will be deployed.
   For each of them, the :doc:`manifest JSONs <../ubos-manifest>`
   is processed for each of the roles, and each of the AppConfigurationItems
   is deployed: files are copied, directories created, databases provisioned
   and populated, and scripts run.

#. If an app at the site was previously deployed, the previously backed-up
   data will be restored, and the "upgrade" scripts will be run that were
   specified by the app and any accessories.

#. If an app at the site was not previously deployed, the "installer" scripts
   will be run that were specified by the app and any accessories.

#. The frontpage of the site will be re-enabled.

UBOS uses the ``siteid`` and the ``appconfigid`` fields in the
:doc:`../site-json` to determine whether a site and/or an AppConfiguration is being newly
deployed, redeployed or undeployed. This makes it easy to move a site from one hostname to
another (the Site JSON is the same with the same ``siteid`` and ``appconfigid``, but a
changed ``hostname``), or to move an app from one context path to another (the
``appconfigid`` is the same, just the ``context`` is different).
