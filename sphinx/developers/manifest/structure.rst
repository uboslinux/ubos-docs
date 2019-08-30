Structure of the UBOS Manifest
==============================

A Manifest JSON file has a type declaration, three required components, and
three optional components:

.. code-block:: json

   {
     "type" : "<<type>>",
     "info" : {
        ... info section (not required but recommended)
     },
     "requirestls" :
        ... (optional)
     "roles" : {
        ... roles section
     },
     "customizationpoints" : {
        ... customizationpoints section (optional)
     },
     "appinfo" : {
        ... appinfo section (for Apps only)
     },
     "accessoryinfo" : {
        ... accessoryinfo section (for Accessories only; required for Accessories)
     }
   }

The ``type`` declaration states whether the manifest is for an
:term:`App` or an :term:`Accessory`. An :term:`App` uses:

.. code-block:: json

   "type" : "app"

while an :term:`Accessory` uses:

.. code-block:: json

   "type" : "accessory"

The optional ``info`` section contains user-friendly, localized information about
the :term:`App` or :term:`Accessory`. It is described in :doc:`info`.

If ``"requirestls" : true``, this :term:`App` must only be deployed to :term:`Sites <Site>`
that are protected by TLS.

The required ``roles`` section declares how the :term:`App` wishes to be installed and
configured with respect to Apache, MySQL, and other roles. It is described in
:doc:`roles`.

:term:`Apps <App>` or :term:`Accessories <Accessory>` that support customization declare
their parameters in an optional ``customizationpoints`` section. It is described in
:doc:`customizationpoints`.

In addition, :term:`Accessories <Accessory>` need to provide a ``accessoryinfo`` section to identify
the :term:`App` that they belong to. It is described in :doc:`accessoryinfo`.
