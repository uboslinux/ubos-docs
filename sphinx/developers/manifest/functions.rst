Functions that may be applied to variables
==========================================

Often, a variable cannot be used as-is, but needs to be processed slightly.

For example, before a text string can be inserted into PHP, possible quotes in
the text string need to be escaped. If a blogging :term:`App` defines a
:term:`Customization point` called ``title``, and a user provides
the value ``Bob's Greatest`` in their :term:`Site JSON` for it, a hypothetical
PHP configuration file for this :term:`AppConfiguration` should read as follows:

.. code-block:: none

   $blogTitle = 'Bob\'s Greatest';

to avoid syntax errors. To accomplish this, the developer would use the following
line in their template file:

.. code-block:: none

   $blogTitle = '${escapeSquote( installable.customizationpoints.title.value) }';

instead of:

.. code-block:: none

   $blogTitle = '${installable.customizationpoints.title.value}';


See also :doc:`variables`.

.. note:: Currently, the implementation of functions on those variables is rudimentary.
          Only a single function may be used; they may not be nested or concatenated.

The following functions are currently available:

``base64encode``
   Base64-encode the value.

``base64decode``
   Base64-decode the value.

``cr2space``
   Convert all newlines to spaces. This is useful to convert a multi-line string
   into a single-line string.

``escapeSquote``
   Prepend all single quotes in the string with a backslash, so
   ``abc'def`` becomes ``abc\'def``. This is useful in configuration files where
   values need to be specified as quoted strings, e.g. in PHP.

``escapeDquote``
   Prepend all double quotes in the string with a backslash, so
   ``abc"def`` becomes ``abc\"def``. This is useful in configuration files where
   values need to be specified as quoted strings, e.g. in PHP.

``trim``
   Remove leading and trailing white space from a string.
