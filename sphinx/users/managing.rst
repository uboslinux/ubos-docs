Managing Sites and Apps
=======================

Determine the list of available Apps and Accessories:
-----------------------------------------------------

To see the list of currently available :term:`Apps <App>` and :term:`Accessories <Accessory>`, execute:

.. code-block:: none

   % pacman -Sl hl

``hl`` stands for "headless", i.e. :term:`Apps <App>` and :term:`Accessories <Accessory>` that do not require a display
or keyboard attached to the device running UBOS.

Display the currently installed Sites and Apps
----------------------------------------------

To list the currently installed :term:`Sites <Site>` and :term:`Apps <App>`, execute:

.. code-block:: none

   % sudo ubos-admin listsites

To find out about options for this command, add ``--help`` as an argument to the command.

Display Site information
------------------------

To show information about a currently installed :term:`Site` with hostname ``hostname``, execute:

.. code-block:: none

   % sudo ubos-admin showsite --hostname <hostname>

Interactively create a new Site with a single App
-------------------------------------------------

To quickly set up a new :term:`Site` with a single installed :term:`App` at that :term:`Site` without having
to edit :term:`Site JSON` manually, execute:

.. code-block:: none

   % sudo ubos-admin createsite

If you wish to use SSL/TLS encryption. you need to decide whether you would like to use
a self-signed certificate (recommended for your home network but not for publicly
accessible website), an official certificate that you have purchased, or a
`letsencrypt.org <https://letsencrypt.org>`_ certificate (either work for publicly
available websites). Depending on that:

.. code-block:: none

   % sudo ubos-admin createsite --tls

will ask you to provide the purchased certificate files. Alternatively:

.. code-block:: none

   % sudo ubos-admin createsite --tls --selfsigned

or

.. code-block:: none

   % sudo ubos-admin createsite --tls --letsencrypt

To generate the Site JSON without deploying the :term:`Site`, e.g. in order to then manually
edit the Site JSON:

.. code-block:: none

   % sudo ubos-admin createsite --dry-run --out <site.json>

This will save the created Site JSON in ``<site.json>``. You can deploy it with
``ubos-admin deploy --file <site.json>``

For an annotated example, see :doc:`firstsite`.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/createsite`.


Deploy a Site
-------------

To deploy a :term:`Site` for the first time, or to update an already-deployed :term:`Site`, with
:term:`Site JSON` file ``<site.json>``, execute:

.. code-block:: none

   % sudo ubos-admin deploy [--quiet] [--siteid <siteid>] ... --file <site.json>

You can manually create the Site JSON, or have UBOS create it for you, by executing:

.. code-block:: none

   % sudo ubos-admin createsite --dry-run

and interactively answering the questions asked. For an annotated example, see :doc:`firstsite`.

When deploying a :term:`Site` over the network, option ``--stdin`` may be preferable over option
``--file``. For example, if you maintain your Site JSON files on your workstation's desktop,
the following command allows you to quickly deploy a new :term:`Site`, or update an existing
:term:`Site`, on your UBOS device (hostname ``ubos-pc.local``) over ssh:

.. code-block:: none

   % cat <site.json> | ssh shepherd@ubos-pc.local sudo ubos-admin deploy --stdin

Note: ``ubos-admin createsite`` is just a wrapper around ``ubos-admin deploy``.

.. warning:: If you redeploy a :term:`Site` using a different configuration (e.g. the new configuration
   does not contain the same set of :term:`Apps <App>` as before), this operation may throw away
   valuable data, as this does not create a backup of your data.

To perform a backup first to file ``~/backup.ubos-backup``, and then redeploy the :term:`Site`, execute:

.. code-block:: none

   % sudo ubos-admin deploy --backup ~/backup.ubos-backup --file <site.json>

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/deploy`.

Undeploy a Site
---------------

To undeploy a :term:`Site` with hostname ``<hostname>``, execute:

.. code-block:: none

   % sudo ubos-admin undeploy --hostname <hostname>

.. warning:: This does not create a backup of your data. You need
   :doc:`to do that yourself <backup>`
   first if you would like to retain the data from the to-be-undeployed :term:`Site`.

To perform a backup first to file ``~/backup.ubos-backup``, and then undeploy the :term:`Site`, execute:

.. code-block:: none

   % sudo ubos-admin undeploy --backup ~/backup.ubos-backup --hostname <hostname>

To undeploy all currently deployed :term:`Sites <Site>` at the same time, execute:

.. code-block:: none

   % sudo ubos-admin undeploy --all

Use with care.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/undeploy`.
