``ubos-admin deploy``
=====================

See also :doc:`../../users/ubos-admin`.

If the Site JSON file provided to this command is valid, UBOS will perform the following steps:

#. Install required packages that haven't been installed yet. This includes:

   * the packages of :term:`Apps <App>` to be deployed per the the Site JSON, but not yet
     installed on the device;
   * the packages of :term:`Accessories <Accessory>` to be deployed per the
     Site JSON, but not yet installed on the device;
   * dependencies of those packages as listed in the respective ``PKGBUILD``
     files;
   * packages listed in the ``depends`` section of the
     :doc:`manifest JSONs <../ubos-manifest>` of the
     :term:`App` and :term:`Accessories <Accessory>`, for those roles that are being used on the device.
   * the database engine(s) required for the :term:`App`, if not already installed.

#. If the :term:`Site` has previously been deployed, the existing :term:`Site` will first be suspended, and
   the data of all the :term:`Apps <App>` and :term:`Accessories <Accessory>` at the :term:`Site` will temporarily be backed up.

#. The :term:`Site`'s frontpage will be replaced with a placeholder saying "upgrade in progress".

#. If the :term:`Site` has previously been deployed, all :term:`Apps <App>` and :term:`Accessories <Accessory>` at the
   deployed :term:`Site` will be undeployed.

#. If a backup was requested, the backup will be created.

#. If the :term:`Site` specifies to use a Letsencrypt certificate, and no valid certificate
   is available on the device, ``certbot`` will automatically contact the Letsencrypt
   web service and attempt to obtain a valid certificate for the :term:`Site`. This
   involves the temporary publication of a document in the :term:`Site`'s ``.well-known``
   subdirectory.

   If a valid certificate was found or obtained, the :term:`Site` will then be set up
   with it. If no valid certificate could be obtained (e.g. because Letsencrypt
   could not contact the device due to DNS problems or a lack of public IP
   address, per Letsencrypt requirements), the :term:`Site` will still be set up,
   but without SSL/TLS.

#. All the :term:`Apps <App>` and the :term:`Accessories <Accessory>` in the new Site JSON will be deployed.
   For each of them, the :doc:`manifest JSONs <../ubos-manifest>`
   is processed for each of the roles, and each of the AppConfigurationItems
   is deployed: files are copied, directories created, databases provisioned
   and populated, and scripts run.

#. If an :term:`App` at the :term:`Site` was previously deployed, the previously backed-up
   data will be restored, and the "upgrade" scripts will be run that were
   specified by the :term:`App` and any :term:`Accessories <Accessory>`.

#. If an :term:`App` at the :term:`Site` was not previously deployed, the "installer" scripts
   will be run that were specified by the :term:`App` and any :term:`Accessories <Accessory>`.

#. The frontpage of the :term:`Site` will be re-enabled.

UBOS uses the ``siteid`` and the ``appconfigid`` fields in the
:doc:`../site-json` to determine whether a :term:`Site` and/or an :term:`AppConfiguration` is being newly
deployed, redeployed or undeployed. This makes it easy to move a :term:`Site` from one hostname to
another (the Site JSON is the same with the same ``siteid`` and ``appconfigid``, but a
changed ``hostname``), or to move an :term:`App` from one context path to another (the
``appconfigid`` is the same, just the ``context`` is different).

This command also accepts the ``--template`` flag. In this case, ``ubos-admin deploy``
allows the provided Site JSON file to leave out :term:`SiteIds <SiteId>` and :term:`AppConfigIds <AppConfigId>`,
and automatically generate new IDs before deploying the Site JSON.

This command must be run as root (``sudo ubos-admin deploy``).
