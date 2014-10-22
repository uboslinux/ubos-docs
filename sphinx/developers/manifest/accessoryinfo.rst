Accessoryinfo section
=====================

Accessories must provide this section. Here is an example:

.. code-block:: json

   "accessoryinfo" : {
     "appid" : "wordpress",
     "accessoryid" : "jetpack",
     "accessorytype" : "plugin"
   }

``appid`` is the name of the package that contains the app to which this accessory
belongs. In this example, the accessory belongs to the wordpress app. This value is
required.

``accessoryid`` and ``accessorytype`` are optional fields. If they are given, they
identify the accessory in the terminology of the app that the accessory belongs to:

* ``accessoryid`` is the name of the accessory as the app refers to it. This may or may
  not be the same as the accessory's package name. For example, Wordpress may refer to
  a plugin as "jetpack", while the UBOS package for the plugin is ``wordpress-plugin-jetpack``.
  The domain of this value depends on the app.

* ``accessorytype`` is the type of accessory that this is. For example, Wordpress
  distinguishes between plugins and skins. The domain of this value depends on the app.

