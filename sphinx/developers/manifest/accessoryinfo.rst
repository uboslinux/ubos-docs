Accessoryinfo section
=====================

:term:`Accessories <Accessory>` must provide this section in a :doc:`../ubos-manifest`. Here is an example:

.. code-block:: json

   "accessoryinfo" : {
     "appid" : "wordpress",
     "accessoryid" : "jetpack",
     "accessorytype" : "plugin",
     "requires" : [
       "other-accessory"
     ]
   }

``appid`` is the name of the package that contains the :term:`App` to which this
:term:`Accessory` belongs. In this example, the Accessory belongs to the ``wordpress`` :term:`App`.
This value is required.

``accessoryid`` and ``accessorytype`` are optional fields. If they are given, they
identify the :term:`Accessory` in the terminology of the :term:`App` that the :term:`Accessory` belongs to. This
often makes it easier for :term:`Accessory` activation and the like to perform the correct
action, based on the type of :term:`Accessory`.

For example, Wordpress :term:`Accessories <Accessory>` can be plugins or themes. Their activation is different
depending on their type. If the manifest marks the :term:`Accessory` with the type, as Wordpress
understands it, a general-purpose activation script can perform different actions based
on that type.

* ``accessoryid`` is the name of the :term:`Accessory` as the :term:`App` refers to it. This may or may
  not be the same as the :term:`Accessory`'s package name. For example, Wordpress may refer to
  a plugin as "jetpack", while the UBOS package for the plugin is ``wordpress-plugin-jetpack``.
  The domain of this value depends on the :term:`App`.

* ``accessorytype`` is the type of :term:`Accessory` that this is. For example, Wordpress
  distinguishes between plugins and themes. The domain of this value depends on the :term:`App`.

* ``requires`` is an optional array of other :term:`Accessory` names. If it is given, this
  :term:`Accessory` can only be used successfully for a given :term:`AppConfiguration`, if the listed
  other :term:`Accessories <Accessory>` have also been deployed at the same :term:`AppConfiguration`.
