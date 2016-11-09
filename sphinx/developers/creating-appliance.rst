How to create a UBOS-based appliance running a particular app
=============================================================

Motivation
----------

Imagine you are a developer of an app, and would like to distribute
your app pre-installed on a device or boot medium. For example,
you might want to hand out SD cards for the Raspberry Pi that have
Wordpress installed, so users have to do nothing other than to insert
the SD card into their Raspberry Pi and have Wordpress running.

You could, of course, install UBOS on a master SD card, then deploy
Wordpress to it with ``ubos-admin deploy``, and distribute binary
copies of that master SD card. The trouble with this approach is that
all your users will have to use the same secrets: the same database
passwords, the same password salts etc. For security reasons, that
is not advisable.

Solution
--------

To solve this problem, first create a site JSON file that contains
the configuration of the app or apps as you would like to see them
for all your customers, e.g.::

   ubos-admin createsite -n -o site-template.json

Then, edit the created ``site-template.json`` and remove
instance-specific information, such as:

* the ``siteid``
* each ``appconfigid``
* instance-specific secrets.

To test that this template works as a template, deploy it on a
test device::

   ubos-admin deploy --template -f site-template.json

Once you are satisfied, copy ``site-template.json`` into directory
``/var/lib/ubos/deploy-site-templates-on-boot/`` on the media you would
like to hand out. When a device using the media boots, and UBOS finds a
valid site template in this directory, it will automatically execute
``ubos-admin deploy --template`` as you did above, and deploy the site.
Because it deploys from a template, all the secrets and identifiers will
be unique to the customer's device.

Note: it is recommended you make sure all code necessary to deploy
the site is available on the device without needing access to the network, otherwise
the deploy-on-boot will fail for those customers that boot the device without
being connected to the internet.
