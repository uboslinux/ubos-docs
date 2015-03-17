Setting up networking and DNS
=============================

UBOS is trying to make network setup easy as well. Unfortunately, UBOS can only do so
much because it's usually other computers on the network -- like routers and DNS
servers -- that determine much of what UBOS can and cannot do. Every network tends to
be a bit different, and UBOS is trying to do its best to fit in without requiring
network changes.

UBOS devices typically run apps that you access with a web browser from another device,
your phone or laptop. This only works if those other devices have a way of reliably
finding your UBOS device on the network. Because of that, things are a little bit more
complicated than for other types of devices, like your laptop or phone connecting to WiFi.

IP address
----------

Like most laptops and mobile devices, by default, UBOS devices connected by Ethernet
to your network automatically attempt to obtain an IP address via
`DHCP <https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol>`_. So your
UBOS device should automatically obtain a (random) IP address if you have plugged it into
Ethernet at the time of boot.

If you'd like to have a static IP address for your UBOS device, we recommend that you
configure your DHCP server to always hand out the same IP address to your UBOS device.
This tends to be an easier, and typically more maintainable process than maintaining
static IP addresses on all the devices on your network. For example, depending on the model
of your home router, you may be able to do this:

* Log into the administrative interface of your home router, and look for a page
  that lists all currently connected devices on your network.
* Look for your UBOS device, and note its MAC address.
* In some part of the administrative interface of your home router, you may be
  able to assign a consistent IP address for the device with this MAC address.

mDNS hostnames
--------------

By default, UBOS devices announce themselves on the local-area network with the
following names:

=========================== ===============================
UBOS installed on:          Hostname
=========================== ===============================
PC                          ``ubos-pc.local``
Virtual PC in VirtualBox    ``ubos-vbox-pc.local``
Raspberry Pi                ``ubos-raspberry-pi.local``
Raspberry Pi 2              ``ubos-raspberry-pi2.local``
Beagle Bone Black           ``ubos-bbb.local``
=========================== ===============================

So for example, if you run UBOS on a Raspberry Pi, after the Raspberry Pi has booted,
you should be able to access your Raspberry Pi on your local network at ``http://ubos-rpi.local/``.

Access should work on all operating systems and types of devices, **except on Windows** if
you do not have iTunes installed. (Yes, this sounds strange. Basically, Microsoft does
not support mDNS, but Apple does, and Apple adds it to your Windows PC as soon as you
install iTunes. Apple calls this feature Bonjour.) So if you are unlucky enough to run
Windows, please install iTunes there and mDNS resolution should work.

The advantage of using these mDNS hostnames is that no DNS setup is required, and you do
not need to assign a static IP address to your device.

The disadvantage of using these hostnames is that they only work on the local network,
and that you cannot run more than one site on the same UBOS device.

If you wish to change your device's mDNS hostname, change its Linux hostname, and restart
the Avahi daemon. Assuming you would like the new name to be ``mydevice``, you can do this
by executing the following commands as ``root``:

.. code-block:: none

   > hostname mydevice
   > hostname > /etc/hostname
   > systemctl restart avahi-daemon


Non-mDNS (regular) hostnames
----------------------------

If you would like to use more than one site on the same device, or you would like to
use a hostname of your choosing (say, ``family.example.com``) you need to set up
DNS yourself. This can sometimes be performed in the administration interface of
your home router.

For example, depending on the model of your home router, you may be able to do this:

* Log into the administrative interface of your home router, and look for a page
  that lists all currently connected devices on your network.
* Look for your UBOS device, and note its MAC address.
* In some part of the administrative interface of your home router, you may be
  able to assign a consistent hostnamefor the device with this MAC address.

Unfortunately, this entirely depends on the features of your home router, and is outside
of UBOS's control.
