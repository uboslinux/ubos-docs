Developer FAQ
=============

(See also the :doc:`user FAQ <../users/faq>`.)

Why did you derive UBOS from Arch Linux?
----------------------------------------

The first version of what became UBOS was actually based on debian. There are many
great things about debian, and things were going great, until early users complained that the
versions of the available web apps were "old"; they wanted the latest and greatest.
So we tried upgrading various web apps to current versions, and failed: current web apps
would require current language runtimes and libraries, and debian stable does not generally
provide them.

In the second attempt, we worked from Ubuntu. That was better in terms of being current
with web apps. But when we discovered rolling updates as provided by Arch Linux, there
was no going back: rolling upgrades are excellent for the types of systems we are
building UBOS for.

.. _faq_arch_ubos_rel:

What is the relationship between UBOS and Arch Linux?
-----------------------------------------------------

UBOS is both a subset and a superset of Arch Linux:

* UBOS only includes a subset of the Arch Linux packages. For example, UBOS has picked
  Apache2 as its (current) web server and thus does not provide any other web servers.

* UBOS provides packages such as ``ubos-admin`` for one-command device
  administration, which are not available on Arch Linux. Given that Arch Linux is
  intended as a very configurable system for the power user, and ``ubos-admin`` requires
  a much tighter set of conventions, ``ubos-admin`` does not make much sense on Arch itself.

* UBOS provides several :term:`release channels <Release channel>`.

* UBOS releases are "full-stack" tested before they are made available. Arch Linux
  only performs unit testing, and generally requires a system administrator to
  manually review and resolve possible issues. See also :doc:`buildrelease`.

In spite of this, many packages available on UBOS are identical to those on
`Arch Linux <http://archlinux.org/>`_, and its sibling,
`Arch Linux ARM <http://archlinuxarm.org/>`_.

Doesn’t apt / dpkg / yum / pacman etc. do this already?
-------------------------------------------------------

No. They all manage software packages, they do not manage full configurations of those
packages.

Take WordPress as an example. If you install a WordPress package, a package manager will
dump all the WordPress code on your drive, but it is left to you to create a database and
edit the Apache virtual host configuration. That is in spite of the fact that installing
WordPress is much simpler than installing most web applications where you often also
need to install (or even compile) additional dependencies, and sometimes even get additional
services to run.

If you want to run the same application more than once on the same machine (for example,
at different virtual hosts), package managers are not able to help at all. Certainly they
also don't help with backups, restores, SSL configuration and many other administration
tasks that UBOS helps automate.

P.S. We build on ``pacman`` (the Arch Linux package manager) and each UBOS package is a
valid pacman package.

Doesn’t puppet / chef / ansible etc. do this already?
-----------------------------------------------------

These are large-scale datacenter / IT automation tools, and not written for you and me
putting code on our Raspberry Pi. Conceivably we could build on one of them, but the
upside seemed small compared to the downside.

One key difference is that you and I, and everybody, will put different combinations of
applications on our devices, instead of a devops engineer putting the same combination
of code on many servers. This difference has ramifications on the tools.

What about docker?
------------------

Docker is great to isolate independent apps from each other; it isn't so great for
running, say, 5 instances of Wordpress and 3 of ownCloud on several different virtual
hosts on the same port 80.

You can probably run UBOS inside docker; let us `know <http://ubos.net/community/">`_
if you do.

Why do you recommend to develop in Arch Linux instead of UBOS itself?
---------------------------------------------------------------------

For development, developers usually want to use more packages than are contained in UBOS,
e.g. graphical desktop environments, editors, debuggers, test scripts and so forth. These
are out of scope for UBOS. Most of them are available on Arch Linux, however.

As UBOS is an Arch Linux derivative, this keeps development system and run-time system
close. If you develop in Arch, and run your UBOS apps in a UBOS container, you get the
best of both worlds.

Why do you advise against using a Raspberry Pi or other ARM device as a UBOS development machine?
-------------------------------------------------------------------------------------------------

The Raspberry Pi is fine to run UBOS on. But we recommend you use a PC or virtual machine
to develop for UBOS, for these two reasons:

* Development is not much fun on a slow device, and ARM-based devices like a Raspberry Pi
  are substantially slower than a modern PC

* The Raspberry Pi and other ARM devices use an SD Card as its hard drive. SD Cards,
  unfortunately, do not lend themselves to repeated compile cycles, and have a habit of
  dying when over-used, perhaps taking your code with them.

If you must use an ARM-based device, we recommend that at least you store your valuable code
on an external (USB) hard drive. Compilations will be faster, too.

How are the various UBOS images different from each other?
----------------------------------------------------------

UBOS images for containers are identical to those for physical machines, except that
they do not run certain services by default which are usually provided by the
host (such as for setting the system time).

UBOS images for VirtualBox by default run the VirtualBox client tools, which enables
the virtual machine to integrate better with the host system.

The differences between the images on x86_64 are very small; one or two packages installed
or not, and a handful of ``systemctl enable ...`` calls, so if you already have an image
for x86_64, it should be straightforward to use it for physical machine, VirtualBox
or containers without needing to download another image.

The same is true for ARM platforms. However, there are larger differences between the
images for, say, Raspberry Pi 2 and BeagleBone Black, although they use the same ARM
processor architecture. For example, their boot methods are different.

