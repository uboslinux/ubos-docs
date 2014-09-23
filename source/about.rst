About UBOS
==========

UBOS Goals
----------

UBOS was created:

 * to make systems administration of :term:`personal servers <Personal Server>` 10 times
   faster, 10 times simpler, and 10 times less error-prone.

 * to support the developers of :term:`indie applications <Indie Application>`,
   and of indie technology with a Linux distro specifically for them, so their users can
   be more successful more often running their great new apps in the long term.

Even if you are a hard-core geek, UBOS can save you a lot of time and hassle because it
automates a lot of time-consuming, error-prone manual configuration work that you have to do on
other distros. If you are not, UBOS makes even complex setups easy. Don't know how to
configure SSL? With UBOS, you don't need to!

Actually, we strive to do better than "10 times faster and simpler and more reliable",
but everybody has got to start somewhere :-)

About Personal Servers
----------------------

A personal server is any computer that is owned by you and that you access with a web
browser from your phone, your tablet, or PC, over the network. Personal servers can be big
and expensive, or can be small and cheap like a Raspberry Pi.

Depending on what :term:`indie applications <Indie application>` you install, it can be used
for most things that "the cloud" can be used for, such as a file server, to share calendars
or photos, or post status updates to your friends.

But unlike "the cloud", your personal server is your's: you decide which data to store there
and which not, which apps you run, or under which conditions you let others use it. Privacy
is there by default: none of your data ever leaves, or is accessed by anybody unless you
let them.

Personal server are also great to connect Internet-of-Things devices.

UBOS Features:
--------------

 * With UBOS, **web applications can be installed, and fully configured with a single command**.
   This takes out the drudgery of software installation and configuration on servers and
   allows many more people to run their own :term:`indie applications <Indie application>`.

   Wanting to run a, say, Python app should not require users having to know anything
   about Python; same about other languages, frameworks, databases and the like. You don't
   care about which language was used to create apps on your smart phone either.

   On UBOS, unlike other Linux distros, a typical user never has to edit a Linux-level configuration
   file (say in ``/etc/``), provision a database, start or stop services, and the like.

 * On UBOS, even **websites that use SSL, and/or run multiple web apps can be deployed with a
   single command**. For sites that use SSL, incoming http requests are automatically redirected to https;
   the user does not need to configure anything other than providing the SSL certificate
   information.

   On other distros, this requires notoriously-difficult manual Apache SSL configuration.

 * UBOS **pre-installs and pre-configures networking and other infrastructure**, so it
   is ready to be used as soon as it has booted. For example, not only does UBOS boot as a
   dhcp client, but also runs a web server with a default web application.
   This allows the user to use UBOS immediately, with little to no systems configuration.

   On other distros, this is an open-ended manual process.

 * UBOS **"full-stack testing"** ensures that core UBOS operating system, networking, middleware,
   and apps, are all tested with each other before a new UBOS release is pushed out. This
   reduces the likelihood that, for example, an upgrade to the database or web server will
   break a web application.

   Some Linux distros perform similar testing with desktop applications, but we are not
   aware of any other distros that do it for server-side, web applications.

 * Unlike most other distros, UBOS does not try to provide every conceivable package.
   Instead, we try to provide **as few packages as possible** by eliminating alternate packages
   that provide the same functionality. For example, we picked Apache over nginx (due to
   broader software support). To support the goals of UBOS, this has great advantages: for
   example, it makes testing much simpler, because UBOS has far less code, and far fewer
   configurations need to be tested. This in turn makes application developers' lives
   easier.

   Users who wish to use other packages not provided through UBOS can still obtain those
   from the Arch Linux repositories. UBOS is a (compatible) derivative of Arch Linux.

 * UBOS uses a `rolling-release <https://en.wikipedia.org/wiki/Rolling_release>`_
   development model. UBOS never requires major upgrades; instead, updates are
   made available incrementally. This ensures that devices can continue to be updated
   and keep running for the long-term.

 * UBOS is all **free/libre and open software**, so there's no proprietary lock-in.
   There is one exception: some hardware platforms, notably some versions of ARM,
   require "blobs" to function. (The Free Software Foundation provides a
   `great description <https://www.fsf.org/resources/hw/single-board-computers>`_ of the
   problem.) UBOS bundles those blobs (but only on those platforms) in order to be able to
   support those platforms. Of course, you can install whatever software you like on
   your personal server running UBOS.

Thank you, Arch Linux
---------------------

UBOS is a derivative of the great `Arch Linux <http://archlinux.org/>`_ distro. We try
to use as many packages as possible directly from Arch, even without rebuilding.
Thank you, Arch Linux, we couldn't do without you!

