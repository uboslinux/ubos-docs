Managing sites and apps
=======================

Display the currently installed sites and apps
----------------------------------------------

To list the currently installed sites and apps, execute:

.. code-block:: none

   > sudo ubos-admin listsites

To find out about options for this command, add ``--help`` as an argument to the command.

Display site information
------------------------

To show information about a currently installed site with :term:`siteid` <siteid>, execute:

.. code-block:: none

   > sudo ubos-admin showsite --siteid <siteid>

You can abbreviate the siteid by appending three dots, if what you specify is unique.
You can also use ``--hostname <hostname>`` instead.

Interactively create a new site with a single app
-------------------------------------------------

To quickly set up a new site with a single installed app at that site without having
to edit :term:`Site JSON` manually, execute:

.. code-block:: none

   > sudo ubos-admin createsite

If you wish to use SSL/TLS encryption, execute:

.. code-block:: none

   > sudo ubos-admin createsite --tls

or

.. code-block:: none

   > sudo ubos-admin createsite --tls --selfsigned


To generate the Site JSON without deploying the site, e.g. in order to then manually
edit the Site JSON:

.. code-block:: none

   > sudo ubos-admin createsite --dry-run --out <site.json>

This will save the created Site JSON in ``<site.json>``. You can deploy it with
``ubos-admin deploy --file <site.json>``

For an annotated example, see :doc:`firstsite`.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/createsite`.


Deploy a site
-------------

To deploy a site for the first time, or to update an already-deployed site, with
:term:`Site JSON` file ``<site.json>``, execute:

.. code-block:: none

   > ubos-admin deploy [--quiet] [--siteid <siteid>] ... --file <site.json>

You can manually create the Site JSON, or have UBOS create it for you, by executing:

.. code-block:: none

   > sudo ubos-admin createsite --dry-run

and interactively answering the questions asked. For an annotated example, see :doc:`firstsite`.

When deploying a site over the network, option ``--stdin`` may be preferable over
option ``--file``. For example, if you maintain your Site JSON files on your desktop,
the following command allows you to quickly deploy a new site, or update an existing
site, on your UBOS device (hostname ``ubos-pc.local``) over ssh:

.. code-block:: none

   > cat <site.json> | ssh ubos-admin@ubos-pc.local sudo ubos-admin deploy --stdin

Note: ``ubos-admin createsite`` is just a wrapper around ``ubos-admin deploy``.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/deploy`.

Undeploy a site
---------------

To undeploy a site with siteid ``<siteid>``, execute:

.. code-block:: none

   > sudo ubos-admin undeploy --siteid <siteid>

.. warning:: This does not create a backup of your data. You need
   :doc:`to do that yourself <backup>`
   first if you would like to retain the data from the to-be-undeployed site.

You can abbreviate the siteid by appending three dots, if what you specify is unique.
You can also use ``--hostname <hostname>`` instead.

.. code-block:: none

   > sudo ubos-admin undeploy --all

will undeploy all currently deployed sites. Use with care.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/undeploy`.
