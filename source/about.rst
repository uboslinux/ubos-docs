About UBOS
==========

Context
-------

Consider the `Raspberry Pi <http://raspberrypi.org/>`_: for USD $35, you get a credit
card-sized computer that just a few years ago would have qualified as a
`"server" <https://en.wikipedia.org/wiki/Server_%28computing%29>`_.
In fact, many makers use it as a server for personal file or web sites, or
various :term:`Indie IoT` and home automation projects. While the Raspberry Pi
currently is the most famous, there are many other tiny computers that are not much
more expensive and even more powerful, such as the BeagleBone series, the CubieBoard,
the Wandboard, and
`many others <https://en.wikipedia.org/wiki/Comparison_of_single-board_computers>`_.

There is just one problem. Regardless whether the hardware is massive and expensive (such
as those used for high-traffic websites), or cheap and tiny like the Raspberry Pi:
**servers are complex to set up, and take a lot of time to maintain**. They typically
require expert-level server administration knowledge, which only hard-core geeks have. And
even those geeks who have the ability to maintain their own servers often do not have the
time to do so. But poorly maintained servers are a major security risk, and what's the fun
in a cool project if it stops running or its software is quickly out of date because nobody finds
the time for ongoing systems administration?

It's even more difficult for embedded computers: they may be hidden in the back of
a closet or even be built "into" some thing. Not only are they often difficult to reach
when something goes wrong, they usually don't even have a keyboard or a monitor, so
maintenance can be a real headache.

This is also a big problem for vendors shipping hardware with one of those boards
inside: software still needs to updated, and the device needs to be maintained;
unpatched embedded systems are recognized as one of the major security risks for the
industry going forward.

UBOS Goals
----------

UBOS was created:

 * to make systems administration of :term:`personal servers <Personal Server>` 10 times
   faster, 10 times simpler, and 10 times less error-prone, so that everybody can
   successfully own and use their own personal servers and does not need to become part
   of some big internet company's take-over-the-world and spy-on-everybody strategy;

 * to support the developers of :term:`indie web applications <Indie Web Application>`,
   and of indie technology with a Linux distro specifically for them, so they have one thing less
   to worry about and can focus on creating great new products that delight their users.

Actually, we strive to do better than "10 times faster and simpler and more reliable",
but everybody has got to start somewhere :-)

UBOS Features:
--------------

 * With UBOS, **web applications can be installed, and fully configured with a single command**.
   This takes out the drudgery of software installation and configuration on servers and
   allows many more people to run their own :term:`indie web applications <Indie Web Application>`.

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
   larger software support). To support the goals of UBOS, this has great advantages: for
   example, it makes testing much simpler, because UBOS has far less code, and far fewer
   configurations need to be tested. This in turn makes application developers' lives
   easier.

   Users who wish to use other packages not provided through UBOS can still obtain those
   from the Arch Linux repositories. UBOS is a (compatible) derivative of Arch Linux.

 * UBOS uses a `rolling-release <https://en.wikipedia.org/wiki/Rolling_release>`_
   development model. UBOS never requires major upgrades; instead, updates are
   made available incrementally. This ensures that devices can continue to be updated
   and keep running for the long-term.

 * UBOS only uses **free/libre and open software**, so there's no proprietary lock-in.
   There is only one exception: some hardware platforms, notably some versions of ARM,
   require "blobs" to function. (The Free Software Foundation provides a
   `great description <https://www.fsf.org/resources/hw/single-board-computers>`_ of the
   problem.) UBOS bundles those blobs (but only on those platforms) in order to be able to
   support those platforms. Developers are strongly encouraged not to develop code that
   depends on such "blobs".

Thank you, Arch Linux
---------------------

UBOS is a derivative of the great `Arch Linux <http://archlinux.org/>`_ distro. We try
to use as many packages as possible directly from Arch, even without rebuilding.
Thank you, Arch Linux, we couldn't do without you!

