Appinfo section
===============

:term:`Apps <App>` may optionally provide this section in a :doc:`../ubos-manifest`.
Here is an example:

.. code-block:: json

   "appinfo" : {
     "defaultaccessoryids" : [
       "accessory1",
       "accessory2"
     ]
   }

In this example, the :term:`App` specifies that if no :term:`Accessories <Accessory>`
have been specified for an :term:`AppConfiguration` running this :term:`App`,
the default :term:`Accessories <Accessory>` ``accessory1`` and ``accessory2`` shall
be deployed.

This makes it easier for users to install :term:`Apps <App>` in a reasonable default
configuration.
