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
:term:`Accessories <Accessory>` to itself. And: UBOS curates :term:`Accessories <Accessory>`,
so you can be fairly certain that the ones provided through UBOS actually work.

How to skip a Nextcloud version during upgrade
----------------------------------------------

If you don't update your UBOS device regularly, it may happen that you missed an entire
major Nextcloud release by the time you do finally upgrade. For example, if you deployed
your site originally with Nextcloud 14, and waited a while to upgrade, the current
version may now be Nextcloud 16. This is a problem because Nextcloud does not support
skipped upgrades.

This is issue is a known Nextcloud issue, and really needs to be solve by the Nextcloud
developers. We can only provide workarounds. The best one, of course, is the regularly update
your UBOS device, so you do not end up in this situation. But if you do anyway, here is a
possible workaround.

First: determine whether you are indeed in this situation, by determining which version
of Nextcloud you are currently running. Execute:

.. code-block:: none

   % pacman -Qi nextcloud

This section applies to you if the version you have installed starts with 14. Upgrades
do not require this workaround if your version starts with 15 or 16.

* Before you attempt to upgrade your device, create a backup of your Nextcloud installation
  with ``ubos-admin backup``.
* Undeploy Nextcloud with ``ubos-admin undeploy``. Depending how you have set up your site(s),
  it might be easiest to undeploy the entire site, or all sites, on your device.
  (Make triply sure first that you have a backup for everything you will undeploy!)
* Upgrade your device with ``ubos-admin update``.
* Now restore your backup, while telling UBOS to replace package ``nextcloud`` with
  package ``nextcloud15`` (the skipped version) during the restore. You do that with
  additional arguments: ``ubos-admin restore --migratefrom nextcloud --migrateto nextcloud15``.
  This will migrate your Nextcloud data to version 15, from which the regular upgrade
  works.
* But we also need to replace ``nextcloud15`` with the now-current ``nextcloud``, so
  we go through backup and restore one more time: ``ubos-admin backup`` and then
  ``ubos-admin restore --migratefrom nextcloud15 --migrateto nextcloud``.
* Now you should be back and running. You can clean up by removing the intermediate
  version with ``pacman -R nextcloud15``.
