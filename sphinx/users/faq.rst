User FAQ
========

(See also :doc:`troubleshooting` and the :doc:`developer FAQ <../developers/faq>`.)

Why is it called UBOS?
----------------------

Why not? :-)

Also, you can pronounce it in a way that makes a lot of sense for the kinds of things
UBOS was created to do.

Why does UBOS ask for a domain name when installing a new site?
---------------------------------------------------------------

UBOS mostly cares about applications that are accessible over the web. To access an
application over the web, your browser needs to know which server to talk to (the web is
a big place!) and the common way of doing that is to use domain (DNS) names. This is
why ``ubos-admin createsite`` asks for a domain name.

I own a domain name, and I'd like to use it for my UBOS device. How do I do that?
---------------------------------------------------------------------------------

Generally, you do two things:

* When you set up your site with ``ubos-admin createsite``, you specify that domain name.
  (You could also say ``*``, but if you specify the domain name you can later add another
  site with a different domain name that runs on the same UBOS device.)
* You instruct your domain name registrar or name server to resolve your domain to your
  UBOS device. The exact details of this process depend on your registrar or name server,
  so we cannot describe this here. But in general, you set up an "A" record that points
  to the IP address of your UBOS device.

Can I use UBOS without purchasing a domain name?
------------------------------------------------

Yes:

* You can use the IP address of your UBOS device instead of a domain name, if you
  have specified ``*``, or the IP address directly as the domain name when executing
  ``ubos-admin createsite``.
* If you are satisfied with accessing your UBOS device only on your local network,
  the UBOS device advertises itself via mDNS and you can use that name. See :doc:`networking`.
* You can enter your site name in your ``/etc/host`` file(s) or in the local DNS
  server of your home router. This makes most sense if your site is only on your
  local network anyway.

How can I install more than one web app on the same device?
-----------------------------------------------------------

Yes. In two ways:

* You can invoke ``ubos-admin createsite`` as many times as you wish and specify as
  many apps as you wish. You can even specify the same app more than once (for example,
  if several members of your family like to run Wordpress) as long as you use different
  path names. However, every time you invoke ``ubos-admin createsite`` again, you need
  to use a different hostname: ``createsite`` means that you are creating a separate
  site every time; the command cannot modify an existing site.
* You can augment an existing site by adding another app to the same site, accessible
  at the same hostname. To do that today, you need to obtain the existing site's
  site JSON file with ``ubos-admin showsite --json --hostname <hostname>``, save
  the file, edit the file by adding another entry into the ``appconfigs`` array
  that describes the additional app you wish to run, and deploy the new configuration with
  ``ubos-admin deploy -f <edited-site-json-file>``. There is currently no command
  that allows you to do that interactively (but you could help us out and create one,
  see `this issue <https://github.com/uboslinux/ubos-admin/issues/8>`_).

How do I set up WiFi?
---------------------

There's a `blog post <http://ubos.net/blog/2016/08/18/wifi.html>`_ on the subject.

Is it safe to have my site accessible from the public web?
----------------------------------------------------------

This is one of these unanswerable questions. Like: is it safe to go on a two-week vacation
or will my house be broken into while I'm gone? We can't quite answer that question.

But here are some thoughts:

* As long as UBOS is in beta, assume there are bugs.
* Once UBOS is out of beta, still assume that there are bugs.
* To see which bugs have been filed, go to `Github <https://github.com/uboslinux/>`_.
* As an open-source project, UBOS is "as-is" and we make no warranties of any kind.
* So far, we are not aware of any break-in or compromise of any UBOS system by
  anybody.
* We run UBOS ourselves, and we definitely don't want to be compromised.

I'd have more space on my device and would like UBOS to use it
--------------------------------------------------------------

This is an expert-level operation; you can very easily screw your existing UBOS
installation and all data on it. So be very careful. In principle, it should work,
however.

Generally, first determine what filesystem your UBOS root partition runs on. On most
devices, UBOS runs on "btrfs" but it might be "ext4". Then, use a command
specific to that filesystem type to expand the filesystem, such as
``btrfs filesystem resize`` (for "btrfs) or ``resize2fs`` (for "ext4"). Alternatively,
you can add a second device to the btrfs filesystem pool.

I'm trying to run UBOS in a container, and the container comes up degraded
--------------------------------------------------------------------------

Make sure you have IPv6 enabled on your host. If you run the container on
a UBOS host itself, it may be as easy as ``ubos-admin setnetconfig client``
(or whatever netconfig you are running on the host).

I need a package that isn't in UBOS
-----------------------------------

If so, please file a `bug against the apps-wanted repository <https://github.com/uboslinux/apps-wanted/issues/new>`_,
stating the name of the package and why you think you need it. It would be best if you
could identify the exact package name in the `Arch Linux repositories <https://www.archlinux.org/packages/>`_
and/or the link to the project developing it. When that happens, we usually add the package
to the next UBOS release.

In the meantime, you can install most Arch Linux packages directly on UBOS: download
the package for your hardware platform (x86 from the `Arch Linux project <https://www.archlinux.org/>`_,
and ARM from the `Arch Linux ARM <https://www.archlinuxarm.org/>`_ project), and
use ``pacman -U`` to install.

I need root
-----------

You should be able to do all typical systems administration with the ``shepherd`` account.
It is permitted to perform ``sudo <cmd>`` for those commands that require root privileges,
but no more, in order to cut down on inadvertent changes that will get in the way of UBOS'
way of doing things. So: "This is not the account you are looking for."

However, if you insist, there are two easy ways of getting root:

* On a system where you have access to the console, you can simply log into the console
  as ``root``. By default, there is no password. (The assumption is that if somebody has
  physical access to your Raspberry Pi, game is over anyway, security-wise).
* As user ``shepherd``, invoke ``sudo bash``. This will give you a root shell.

I found a bug.
--------------

Please tell us about it by filing it
`on Github <https://github.com/uboslinux/ubos-admin/issues/new>`_.

Help! I have trouble!
---------------------

What about visiting our :doc:`troubleshooting` section?

Help! I want to help!
---------------------

Come find us `here <http://ubos.net/community/>`_ and raise your hand to
volunteer!

What should I do if I get an error, and I don't know how to solve it myself?
----------------------------------------------------------------------------

Here are some things you can do:

* Consult the `UBOS user documentation <http://ubos.net/docs/users/>`_, in particular
  the section about :doc:`troubleshooting`.
* Ask a friendly Linux geek you might know.
* Come find us `here <http://ubos.net/community/>`_ and ask.
