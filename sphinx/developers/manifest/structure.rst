Structure of the UBOS Manifest
==============================

A Manifest JSON file has a type declaration, three required components, and
two optional components:

.. code-block:: json

   {
     "type" : "<<type>>",
     "info" : {
        ... info section (not required but recommended)
     },
     "roles" : {
        ... roles section
     },
     "customizationpoints" : {
        ... customizationpoints section (optional)
     },
     "accessoryinfo" : {
        ... accessoryinfo section (for accessories only)
     }
   }

The ``type`` declaration states whether the manifest is for an
:doc:`app or an accessory <../appsaccessories>`. An app uses:

.. code-block:: json

   "type" : "app"

while an accessory uses:

.. code-block:: json

   "type" : "accessory"

The optional ``info`` section contains user-friendly, localized information about
the app or accessory. It is described in :doc:`info`.

The required ``roles`` section declares how the app wishes to be installed and
configured with respect to Apache, MySQL, and other roles. It is described in
:doc:`roles`.

Apps or accessories that support customization declare their parameters in
an optional ``customizationpoints`` section. It is described in
:doc:`customizationpoints`.

In addition, accessories need to provide a ``accessoryinfo`` section to identify
the app that they belong to. It is described in :doc:`accessoryinfo`.
