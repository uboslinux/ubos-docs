Customization points section
============================

Apps and accessories may defined "customization points", which enable the user to
configure the app or accessory at deploy time.

If you invoke ``ubos-admin createsite`` and specify an app that declares one or more
required customization points, you will be asked for values for those customization points.
(If you specify ``--askForAllCustomizationPoints`` as argument, you will be asked for
values for all customization points, not just the requires ones.)

Here is an example:

.. code-block:: json

   "customizationpoints" : {
     "title" : {
       "type"        : "string",
       "required"    : false,
       "default" : {
         "value" : "My wiki"
       }
     }
   }

This app, or accessory, declares a single customization point whose programmatic name is
``title``. It is of type string, meaning that values provided for it must be valid strings.
No value has to be provided by the user for this customization point; if none is provided,
the default value "My wiki" will be used instead.

Customization points are useful to set information such as the title of the installed
app, a logo, or settings such as whether comments should be allowed etc.

The following types of customization points are currently recognized:

* ``string``: A text string. May not contain newlines.
* ``email``: A valid e-mail address.
* ``text``: A text string that may contain many lines.
* ``password``: A password. UBOS may enforce certain rules about password strength.
* ``boolean``: Either ``true`` or ``false``.
* ``integer``: A whole number that may be positive, negative or zero.
* ``positiveinteger``: A whole number that must be 1 or greater.
* ``positiveintegerorzero``: A whole number that must not be negative.
* ``image``: An image in a supported file format.

The default value may be provided in encoded form. For example, a GIF image may be
provided in base64 encoding. Currently only plain (the default) and base64 encoding are
supported. To provide a default value in base64 encoding, add an ``encoding`` field like
this:

.. code-block:: json

   "default" : {
     "value" : "...",
     "encoding" : "base64"
   }

Customization points may be declared as private:

.. code-block:: json

   "customizationpoints" : {
     "apikey" : {
       "type"       : "string",
       "private"    : true ...
     }
   }

If declared as private, only ``root`` is allowed to see the provided values.

By default, ``ubos-admin createsite`` will ask the user for values of customization points
in a random sequence. To order the sequence in which the questions are asked, add
an ``index`` field whose value is an integer, and which is used for sorting.
For example:

.. code-block:: json

   "customizationpoints" : {
     "last" : {
       "type"       : "string",
       "index"      : 3
     },
     "first" : {
       "type"       : "string",
       "index"      : 1
     },
     "middle" : {
       "type"       : "string",
       "index"      : 2
     },
   }

These customization points will be presented to the user in sequence ``first``, ``middle``,
``last``.
