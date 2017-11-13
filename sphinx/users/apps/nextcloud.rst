Notes on Nextcloud
==================

How to install Nextcloud "apps"
-------------------------------

First, let's be clear about our terminology:

* In UBOS terminology, Nextcloud is an app, like Wordpress or Mediawiki.
* In UBOS terminology, anything that adds functionality to an app is called
  an accessory.
* Nextcloud doesn't call itself an app. Instead, it calls code that adds functionality
  to Nextcloud (like the Nextcloud calendar or address book) an app.

Armed with this understanding, how does one install what Nextcloud calls an app, and
what UBOS calls a Nextcloud accessory? Usually, you would log into your Nextcloud
installation as administrator, navigating to the apps pages, and pick install new ones
from there.

This is not how it works on UBOS.

When you run Nextcloud on UBOS, you need to specify your accessories at the time
you create your site, or by redeploying the site later with an updated configuration.

Example: let's say you want to use the Nextcloud "Calendar" app for your site. When
you create the site with ``ubos-admin createsite``, you specify ``nextcloud`` as your
app, and ``nextcloud-calendar`` as an accessory. You can specify multiple
accessories.

Here's the reason why: UBOS cannot manage apps that change their code base without
UBOS knowing, and that's what would be happening if Nextcloud got to add "apps" aka
accessories to itself. And: UBOS curates accessories, so you can be fairly certain
that the ones provided through UBOS actually work.
