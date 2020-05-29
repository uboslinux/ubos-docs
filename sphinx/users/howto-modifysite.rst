How to modify the configuration of your Site
============================================

Let's say you have a :term:`Site` running on your device, with an :term:`App` or several,
and you'd like to make changes to your configuration. Here are some ideas how to go about
it for common scenarios.

Common to all these scenarios that you need to obtain your :term:`Site`'s
:term:`Site JSON`, make a modification to that :term:`Site JSON`, and then redeploy it.
So let's first talk about this.

First, let's figure out what :term:`Sites <Site>` are currently running on your device:

.. code-block:: none

   % ubos-admin listsites

This lists the :term:`Sites <Site>` by their hostnames, and some information about which
:term:`App` are deployed at each :term:`Site`.

To obtain the full :term:`Site JSON` for a :term:`Site` with hostname ``example.com``,
including all secret credentials (which is needed if you want to redeploy):

.. code-block:: none

   % sudo ubos-admin showsite --host example.com --json

If your :term:`Site` has hostname ``*`` -- the wildcard -- you need to put that star
into single quotes, otherwise your shell will get in your way:

.. code-block:: none

   % sudo ubos-admin showsite --host '*' --json

That will print the :term:`Site JSON` for the :term:`Site` to the terminal. Because that's a
bit impractical given we want to make changes to it, we rather save that output to a file.
What you call that file is immaterial; in our example we call it the same as the hostname
with the extension ``.json``, such as:

.. code-block:: none

   % sudo ubos-admin showsite --host example.com --json > example.com.json

Now you can edit that file -- here ``example.com.json`` -- with a text editor of your choice,
such as ``vim``. Which edits you want to make depend on what changes you want to make to
your :term:`Site` -- see below.

But once you are done, you redeploy the :term:`Site JSON` like this:

.. code-block:: none

   % sudo ubos-admin deploy --file example.com.json

That's assuming your changed file is called ``example.com.json``.

UBOS will figure out what has changed between the current deployed configuration, and
the modified configuration, and make suitable changes to your device.

.. warning:: Always make a backup of your :term:`Site` before you redeploy. UBOS deletes the
   data of :term:`Apps <App>` or :term:`Accessories <Accessory>` you deleted, or whose
   :term:`AppConfigId` you changed. As mistakes can happen, a backup before redeploy is
   always a good idea.

How to change the context path of an App
----------------------------------------

* Save your :term:`Site JSON` to a file as described above.

* Find the ``context`` element and change its value. For example, modify:

  .. code-block:: none

     "context" : "/blog",

  to:

  .. code-block:: none

     "context" : "/news",

* Redeploy your modified :term:`Site JSON` file as described above.

How to add Letsencrypt TLS to your non-TLS Site
-----------------------------------------------

* Save your :term:`Site JSON` to a file as described above.

* Then add this into your :term:`Site JSON` file on the first level inside the the outer
  curly braces:

  .. code-block:: none

     "tls" : {
         "letsencrypt" : true
     },

  Make sure there is a comma each between what you added and what comes before and after.

* Redeploy your modified :term:`Site JSON` file as described above.

How to add another App to an existing Site
------------------------------------------

* Save your :term:`Site JSON` to a file as described above.

* You can manually add an entire :term:`AppConfiguration` section in your ``appconfigs``
  section. However, that tends to be a bit tedious and easy to get wrong. So we suggest
  copy-paste instead:

* Run ``ubos-admin createsite -n``. (The ``-n`` flag prevents UBOS from actually doing
  the ``createsite``; instead it will only emit :term:`Site JSON` for the :term:`Site`
  it didn't actually create.). Make up some data for the hostname, admin accounts and
  the like; those values won't matter. But enter the :term:`App`, and all information
  about it like host name and :term:`Accessories <Accessory>`, as you want it to be on
  your existing :term:`Site`.

* Once the command has completed, a :term:`Site JSON` file will be printed to the
  terminal. Copy the curly-braced section inside the ``appconfigs`` section. Then,
  insert that section into your existing :term:`Site JSON` file, as a sibling of
  the section (or sections) that are there already inside ``appconfigs``. Make sure
  there is a comma before and after what you added if there is a section before or
  after.

* Redeploy your modified :term:`Site JSON` file as described above.

How to remove an App from an existing Site
------------------------------------------

* Save your :term:`Site JSON` to a file as described above.

* Find the :term:`AppConfiguration` in your :term:`Site JSON`. It would be an element
  in the ``appconfigs`` section, with potentially lots of lower-level entries. Remove
  all of it. (Of course if you have only one :term:`AppConfiguration` at your
  :term:`Site`, it may be easier to simply undeploy the entire :term:`Site`.)

* Redeploy your modified :term:`Site JSON` file as described above.

How to add an Accessory to an AppConfiguration
----------------------------------------------

* Save your :term:`Site JSON` to a file as described above.

* Find the list of already deployed :term:`Accessories <Accessory>`. It looks like this:

  .. code-block:: none

       "accessoryids" : [
         "nextcloud-contacts",
         "nextcloud-calendar"
       ],

  and add the package name of the :term:`Accessory` into that array. For example, if you
  wanted to add the Nextcloud "Deck", you would modify this to read:

  .. code-block:: none

       "accessoryids" : [
         "nextcloud-contacts",
         "nextcloud-calendar",
         "nextcloud-deck"
       ],

* If there aren't any :term:`Accessories <Accessory>` yet at your :term:`AppConfiguration`,
  you will have to add this array, as a sibling of ``appid``.

* Redeploy your modified :term:`Site JSON` file as described above.

How to remove an Accessory from an AppConfiguration
---------------------------------------------------

* Save your :term:`Site JSON` to a file as described above.

* That's easy! Find the name of the :term:`Accessory` in the ``accessoryids`` section,
  and remove it. If that was the only :term:`Accessory`, you can remove the entire
  ``accessoryids`` section, but you don't need to.

* Redeploy your modified :term:`Site JSON` file as described above.


