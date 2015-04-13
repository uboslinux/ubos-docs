Learning from the toy apps
==========================

UBOS provides two "toy" apps that help explain how to package and distribute
real web apps on UBOS:

* "Hello World" is an extremely simple Web applications that just displays Hello World
  when accessed over the web. We use it to give you a taste for what is involved to
  package a real web application for UBOS.
* "Glad-I-Was-Here" is a slightly more complex "guestbook" web application that uses a
  MySQL database to store the guestbook entries. We use it to illustrate how to package
  web apps that use a database. It comes in three versions: one implemented in PHP with
  a MySQL backend, one implemented in PHP with a Postgresql backend, and one in Java
  with a MySQL backend.

You may want to read through the documentation for these apps in this sequence:

.. toctree::
   :maxdepth: 1

   toyapps/helloworld
   toyapps/gladiwashere
   toyapps/gladiwashere-postgresql
   toyapps/gladiwashere-java



