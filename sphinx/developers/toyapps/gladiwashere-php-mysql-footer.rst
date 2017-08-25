An accessory for Glad-I-Was-Here (PHP, MySQL)
=============================================

To demonstrate how accessories work, we created a simple plugin for the
:doc:`PHP/MySQL version <gladiwashere-php-mysql>` that adds a footer to the
Glad-I-Was-Here front page.

If you have not already read through the :doc:`PHP/MySQL version <gladiwashere-php-mysql>`
of Glad-I-Was-Here, we recommend you do so first as we'll only discuss things in this
section that were not covered before.

To obtain the source code:

.. code-block:: none

   > git clone https://github.com/uboslinux/ubos-toyapps

Go to subdirectory ``gladiwashere-php-mysql-footer``.

Package lifecycle and app deployment
------------------------------------

Like all other apps and accessory on UBOS including :doc:`helloworld`,
``gladiwashere-php-mysql-footer`` is built with ``makepkg``, installed with ``pacman``
and deployed with ``ubos-admin``.

.. code-block:: none

   > makepkg -f
   > sudo pacman -U gladiwashere-php-mysql-footer-*-any.pkg.tar.xz
   > sudo ubos-admin createsite

Specify ``gladiwashere-php-mysql`` as the name of the app, and then specify
``gladiwashere-php-mysql-footer`` as the (only) accessory.

Manifest JSON
-------------

Let's examine this accessory's :term:`UBOS Manifest JSON` file. It is similar to an
app's, but often much simpler, and with an extra entry ``accessoryinfo`` that relates the
accessory to the app it belongs to:

.. code-block:: json

   {
       "type"  : "accessory",

       "accessoryinfo" : {
           "appid"         : "gladiwashere-php-mysql",
           "accessoryid"   : "footer"
       },

       "roles" : {
           "apache2" : {
               "appconfigitems" : [
                   {
                       "type" : "file",
                       "name" : "footer.php",
                       "template"     : "tmpl/footer.php.tmpl",
                       "templatelang" : "varsubst"
                   }
               ]
           }
       },
       "customizationpoints" : {
           "message" : {
               "name"     : "message",
               "type"     : "string",
               "required" : true
           }
       }
   }

The ``apache2`` role functions just like in case of an app: take file
``tmpl/footer.php.tmpl`` from the code base, and put it into the root directory of
the app's deployment as ``footer.php`` after having replaced variables in it.

What variables? Well, this template file reads as follows:

.. code-block:: html

   <div class="footer">
    <hr/>
    <h4>Footer, from the <tt>gladiwashere-php-mysql-footer</tt> accessory.</h4>
    <p>Message you entered as customization point: &quot;${installable.customizationpoints.message.value}&quot;</p>
    <hr/>
   </div>

You see the variable ``${installable.customizationpoints.message.value}``, which refers
to the value of customization point ``message``. If you deployed the accessory with
``ubos-admin createsite``, it will have asked you for the value of this customization point,
and that value will be inserted.

Which brings us to the last part of the manifest: the declaration of that customization
point with data type "string". Because it is specified as "required", ``ubos-admin createsite``
asks for the value.

Note that both apps and accessories may (or may not) have any number of customization points.
Customization points are not special to accessories.
