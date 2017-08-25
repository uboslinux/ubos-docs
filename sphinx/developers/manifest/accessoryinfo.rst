Accessoryinfo section
=====================

Accessories must provide this section in a :doc:`../ubos-manifest`. Here is an example:

.. code-block:: json

   "accessoryinfo" : {
     "appid" : "wordpress",
     "accessoryid" : "jetpack",
     "accessorytype" : "plugin",
     "requires" : [
       "other-accessory"
     ]
   }

``appid`` is the name of the package that contains the app to which this accessory
belongs. In this example, the accessory belongs to the ``wordpress`` app. This value is
required.

``accessoryid`` and ``accessorytype`` are optional fields. If they are given, they
identify the accessory in the terminology of the app that the accessory belongs to. This
often makes it easier for accessory activation and the like to perform the correct
action, based on the type of accessory.

For example, Wordpress accessories can be plugins or themes. Their activation is different
depending on their type. If the manifest marks the accessory with the type, as Wordpress
understands it, a general-purpose activation script can perform different actions based
on that type.

* ``accessoryid`` is the name of the accessory as the app refers to it. This may or may
  not be the same as the accessory's package name. For example, Wordpress may refer to
  a plugin as "jetpack", while the UBOS package for the plugin is ``wordpress-plugin-jetpack``.
  The domain of this value depends on the app.

* ``accessorytype`` is the type of accessory that this is. For example, Wordpress
  distinguishes between plugins and themes. The domain of this value depends on the app.

* ``requires`` is an optional array of other accessory names. If it is given, this
  accessory can only be used successfully for a given AppConfiguration, if the listed
  other accessories have also been deployed at the same AppConfiguration.
