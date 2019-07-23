Learning from the toy apps
==========================

UBOS provides two "toy" :term:`Apps <App>` that help explain how to package and distribute
real web :term:`Apps <App>` on UBOS:

* "Hello World" is an extremely simple Web applications that just displays Hello World
  when accessed over the web. We use it to give you a taste for what is involved to
  package web application for UBOS.
* "Glad-I-Was-Here" is a slightly more complex "guestbook" web application that uses a
  relational database to store the guestbook entries. We use it to illustrate how to package
  web :term:`Apps <App>` that use a database. It now comes in four versions:

  * implemented in PHP with a MySQL backend, called ``gladiwashere-php-mysql``;
  * implemented in PHP with a Postgresql backend, called ``gladiwashere-php-postgresql``;
  * implemented in Java with a MySQL backend, called ``gladiwashere-java-mysql``; and
  * implemented in Python/WSGI with a MySQL backend, called ``gladiwashere-python-mysql``

The PHP versions of Glad-I-Was-Here can also be configured with an :term:`Accessory` called
``gladiwashere-php-footer``. This :term:`Accessory` adds additional content (a footer) to the main
web page. This demonstrates the basic functioning of :term:`Accessories <Accessory>`.

Note: These toy :term:`Apps <App>` are published in the ``toyapps`` repository, which is not enabled
by default. For how to enable, see :doc:`/users/enabling-nonstandard-repos`.

You may want to read through the documentation for these :term:`Apps <App>` in this sequence:

.. toctree::
   :maxdepth: 1

   toyapps/helloworld
   toyapps/gladiwashere-php-mysql
   toyapps/gladiwashere-php-mysql-footer
   toyapps/gladiwashere-php-postgresql
   toyapps/gladiwashere-java-mysql
   toyapps/gladiwashere-python-mysql



