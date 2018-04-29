Notes on Nextcloud (App ``nextcloud``)
======================================

How to install Nextcloud "apps"
-------------------------------

First, let's be clear about our terminology:

* In UBOS terminology, Nextcloud is an :term:`App`, like Wordpress or Mediawiki.
* In UBOS terminology, anything that adds functionality to an :term:`App` is called
  an :term:`Accessory`.
* Nextcloud doesn't call itself an app. Instead, it calls code that adds functionality
  to Nextcloud (like the Nextcloud calendar or address book) an app.

Armed with this understanding, how does one install what Nextcloud calls an app, and
what UBOS calls a Nextcloud :term:`Accessory`? Usually, you would log into your Nextcloud
installation as administrator, navigating to the "apps" pages, and pick install new ones
from there.

This is not how it works on UBOS.

When you run Nextcloud on UBOS, you need to specify your :term:`Accessories <Accessory>` at the time
you create your :term:`Site`, or by redeploying the :term:`Site` later with an updated configuration.

Example: let's say you want to use the Nextcloud "Calendar" app for your :term:`Site`. When
you create the :term:`Site` with ``ubos-admin createsite``, you specify ``nextcloud`` as your
app, and ``nextcloud-calendar`` as an :term:`Accessory`. You can specify multiple
:term:`Accessories <Accessory>`.

Here's the reason why: UBOS cannot manage :term:`Apps <App>` that change their code base without
UBOS knowing, and that's what would be happening if Nextcloud got to add "apps" aka
:term:`Accessories <Accessory>` to itself. And: UBOS curates :term:`Accessories <Accessory>`, so you can be fairly certain
that the ones provided through UBOS actually work.
