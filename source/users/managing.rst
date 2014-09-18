Managing sites and apps
=======================

Display the currently installed sites and apps
----------------------------------------------

To list the currently installed sites and apps, execute::

   > sudo ubos-admin listsites

To find out about options for this command, add a ``--help`` argument.

Display site information
------------------------

To show information about a currently installed site with siteid :term:`siteid`, execute::

   > sudo ubos-admin showsite --siteid <siteid>


Interactively create a new site with a single app
-------------------------------------------------

To quickly set up a new site with a single installed app at that site without having
to edit :term:`Site JSON` manually, execute::

   > sudo ubos-admin createsite

To generate the Site JSON without deploying the site, e.g. in order to then manually
edit the Site JSON::

   > sudo ubos-admin createsite --dry-run

For an annotated example, see :doc:`firstsite`.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/createsite`.


Deploy a site
-------------

To deploy a site for the first time, or to update an already-deployed site, with
:term:`Site JSON` <site.json>, execute::

   > ubos-admin deploy [--quiet] [--siteid <siteid>] ... --file <site.json>

You can manually create the Site JSON, or have UBOS create it for you, by executing::

   > sudo ubos-admin createsite --dry-run

and interactively answering the questions asked. For an annotated example, see :doc:`firstsite`.

When deploying a site over the network, option ``--stdin`` may be preferable over
option ``--file``. For example, if you maintain your Site JSON files on your desktop,
the following command allows you to quickly deploy a new site, or update an existing
site, on your UBOS device (hostname ``indiebox``) over ssh::

   > cat <site.json> | ssh ubos-admin@indiebox sudo ubos-admin deploy --stdin

Note: ``ubos-admin createsite`` is just a wrapper around ``ubos-admin deploy``.

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/deploy`.

Undeploy a site
---------------

To undeploy a site with siteid <siteid>, execute::

   > sudo ubos-admin undeploy --siteid <siteid>

.. warning:: This does not create a backup of your data. You need to do that yourself
   first if you would like to retain the data from the to-be-undeployed site.

   (See :doc:`backup`.)

If you are curious what UBOS does under the hood, please refer to
:doc:`/developers/understanding/undeploy`.
