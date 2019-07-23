Troubleshooting
===============

Installation or boot problems
-----------------------------

On a PC: cannot boot UBOS from boot stick
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Q**: I have created a boot stick for x86_64 per instructions in :doc:`installation/x86_bootstick`.
But the PC still boots from the previously installed operating system, not UBOS.

**A**: You probably need to allow booting from USB in your BIOS. Many PCs are shipped with
that setting off:

1. Reboot your PC.
2. Immediately after reboot, the PC's BIOS runs. It usually tells you about a key to
   press to enter "settings" or "BIOS" or such. This key often is the delete key, or
   a function key. Press that key immediately. It tends to pass by quickly, so you
   may have to reboot again to catch it.
3. Once you have entered the BIOS, you need to look for the setting. All BIOS's are
   different, and sometimes this particular setting is really hard to find.
4. When you have found the setting and set it to allow booting from a USB disk, save the settings
   and reboot. The BIOS screen usually tells you how to save and restart.
5. Make sure the UBOS boot stick had been inserted already at the time you reboot.
6. Then, you still might need to find yet another key to press quickly that gives you
   a popup dialog in which you can select which device to boot from.
7. Select the device that seems to be your USB stick. It won't be SATA (that's a built-in
   disk) but might be called PMAP, as BIOS manufacturers like to be cryptic it seems.

On a PC: UBOS boot using grub starts out fine, but then the screen goes blank
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Q**: I am booting UBOS on a PC. The bootloader comes up and starts UBOS.
On a new screen, there are a few more boot messages, and then, the screen goes blank.
What happened?

**A**: Chances are, UBOS is booting just fine. There are just some evil forces that have
conspired to make your screen go blank, so you can't see that UBOS is booting.

The magic incantation that you need is a Linux kernel parameter. Do this:

1. Reboot.
2. When the grub bootloader screen comes up, hit the 'e' key. This will keep grub from
   continuing to boot. Instead, it will give you a window with scary-looking bootloader
   commands in it. That's where you need to apply your evil-forces-banishing
   magic incantation.
3. Move your cursor to the line which starts with ``linux`` and has lots of strange
   other words after it.
4. Move your cursor to the very end of that line, and add your magic incantation. Do not
   change any other words on that line, just add to the end.
5. Then, hit F-10 (or ctrl-X) -- see the bottom of the screen -- to continue the boot
   with your magic incantation present.

**Q**: Now just what is the magic incantation?

**A**: In many cases, it may be ``video=LVDS-1:d``. As magic goes, your mileage may vary
depending on your computer hardware and configuration. More options can be found
`at ibiblio.org <http://distro.ibiblio.org/fatdog/web/faqs/boot-options.html>`_.

**Q**: The magic incantation worked, but do I need to that every time??

**A**: No. When you have booted your PC from a UBOS boot stick, and you install UBOS on a
hard drive permanently on this PC, add an extra argument to the ``ubos-install``
command that holds your magic incantation. For example, if you install UBOS on your
first hard drive, say:

.. code-block:: none

   ubos-install /dev/sda --addkernelparameter video=LVDS-1:d

This will put the incantation into the grub setting permanently.

**Q**: If I forgot to add that kernel parameter during installation, do I need to reinstall?

**A**: No. Open ``/etc/default/grub`` with a text editor of your choice, and look for the
line that starts with ``GRUB_CMDLINE_LINUX_DEFAULT``. Append the parameter you wanted, and save
the file. For example, you may want this line to read:

.. code-block:: none

   GRUB_CMDLINE_LINUX_DEFAULT="quiet video=LVDS-1:d"

Then, update your boot loader by invoking:

.. code-block:: none

   grub-install --recheck /dev/sda

Of course, specify a device name other than ``/dev/sda`` if you boot from a different hard drive.

On any device: nothing happens when UBOS is supposed to be booting
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Chances are, your boot stick or SD card (depending on the device you are using)
is bad, or writing the UBOS disk image to the card wasn't successful. This unfortunately
happens. We recommend you write the image on the disk or stick again, and try again.
If that fails, try a different boot stick or SD card.

Message: Failed to create file /sys/devices/system/cpu/microcode/reload when running ubos-install
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is harmless. You can ignore it.

Systemd problems
----------------

Determining status
^^^^^^^^^^^^^^^^^^

To check the status of the services running on your device, invoke:

.. code-block:: none

   systemctl is-system-running

This should say ``running``, except when the system is not fully booted yet, which it
should say ``starting``. If it says ``degraded``, something went wrong and one or more
services could not be started. To find out which, invoke:

.. code-block:: none

   systemctl --failed

This shows you the list of services that are supposed to be running, but failed to do so.

Restarting a service
^^^^^^^^^^^^^^^^^^^^

Assume service ``foo`` has failed, you can attempt to restart the service:

.. code-block:: none

   systemctl restart foo

and see whether that helps. To find out what might have gone wrong, consult the system
journal about this service:

.. code-block:: none

   journalctl -u foo

If you cannot determine what went wrong, see "I need help" below.

In a container: problems with "IPv6 Packet Filtering Framework"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you run UBOS in a container, and during boot, you get a message that says "Failed to
start IPv6 Packet Filtering Framework", or if one of the failed services is
``ip6tables``, chances are that your host operating system does not have IPv6 enabled.

Usually, that requires you to manually load the respective kernel extension. If your
host operating system is Arch Linux, simply execute, in the host:

.. code-block:: none

   % sudo modprobe ip6_tables

and reboot your container.

To make this permanent, create file ``/etc/modules-load.d/ip6_tables.conf`` with the following
single line of content:

.. code-block:: none

   ip6_tables

and have systemd pick it up with:

.. code-block:: none

   % sudo systemctl restart systemd-modules-load

Logging on problems
-------------------

I can't log on via SSH
^^^^^^^^^^^^^^^^^^^^^^

To log into your UBOS device over the network with SSH, you need to have set up the
:doc:`UBOS shepherd account <shepherd-staff>` (or some other account). While you can log
into your UBOS device as root from the console, you cannot log on as root over the network
at all. This is generally considered good security practice on Linux.

My non-English keyboard layout is all screwed up
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To reconfigure your keyboard for your language, follow the
`instructions from Arch Linux <https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console>`_.

Database problems
-----------------

"Cannot access MySQL database. File missing: /etc/mysql/root-defaults-ubos.cnf"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is known to happen under some circumstances if you run UBOS from a very slow disk, such
as a USB 2.0 stick. During startup of the database engine (MySQL/MariaDB) required by
certain apps, a timeout may have occurred that prevents the database initialization
from completing.

You can try to start the database manually with:

.. code-block:: none

   % sudo systemctl start mysqld.service

and then attempt to re-install your app. If this does not work, use a faster disk.

App installation and management problems
----------------------------------------

There's an error message about pacman and gpg when attempting to install an App
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Most likely, UBOS isn't finished generating its cryptographic keys on the first boot.
Execute:

.. code-block:: none

   % sudo systemctl is-system-running

and only proceed once its reports "running".

On any device: a package not found error when installing a new App
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This can happen if you haven't updated your UBOS device for some time. ``ubos-admin``
will attempt to install a package that has been upgraded since, and can't find the
old version.

Always execute ``ubos-admin update`` before installing a new :term:`App`.

On any device: "key is disabled" or "invalid or corrupted package" when installing a package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This message is triggered when UBOS cannot verify that a package file has been created
by a trusted developer (i.e. one whose public key is listed as "trusted" in pacman's
trust database). Note that this error message is slightly misleading, as there are several
conditions that cause this message, not just one:

* the signature for the file is invalid (e.g. just made up)
* the signature for the file is valid, but pacman's trust database does not have the needed
  public key to verify it
* the signature for the file is valid, pacman's trust database has the public key to
  verify it, but the key is not marked as trusted in pacman's trust database.

* the package indeed was created by a non-trusted developer. This is unlikely, unless
  you created the package yourself. If you decide that you wish to trust the developer
  (such as yourself) in spite of UBOS' policies, use ``pacman-key`` to add the key
  to pacman's gpg database
* your trust database is out of date.

Installation or update problems
-------------------------------

On any device: "Cannot create a temporary backup; the backup directory is not empty"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You have run into a UBOS safety feature. Previously, you must have performed some kind
of ``ubos-admin`` operation (like a system update or site redeploy) that encountered
a problem of some kind. This is not supposed to happen. However, it can happen if, for
example, the power went out during a UBOS administration operation, or if you made some
change to your system outside of what UBOS expects you to do. (The reason you are
encouraged to not become ``root``.)

When UBOS recognized that there was a problem, it kept a copy of the potentially affected
application data around in directory ``/ubos/backup/update``. This is now still there,
and UBOS will refuse to perform other operations until you have disposed of that
data there.

When this message appears, you should:

* check that all application data you expect to be there is still managed by the app(s)
  running on your device. Depending on which app(s) you have installed, one way of doing this
  may be to log into your app(s) over the web, and make sure your files, blog posts,
  uploads, and such (depending on your apps) are all there in those apps.

* if you are quite certain that everything is there, it appears that UBOS was overly careful
  and you can delete directory ``/ubos/backup/update``. UBOS is trying to err on the side
  of being overly careful, instead of on the side of risking application data loss.

* If your app(s) appear to be non-functional, or application data appears to be missing,
  try to run ``sudo ubos-admin update-stage2``. This may or may not succeed, depending
  on what the original problem was.

* if all fails, move the entire ``/ubos/backup/update`` directory, recursively, into
  a safe place. Then re-install your applications and manually restore the application
  data contained in this directory hierarchy.

* or, if you are just fooling around with UBOS and there is no valuable data on your
  device, you can simply delete the ``/ubos/backup/update`` directory hierarchy and
  continue what you were doing.

Image problems
--------------

In VirtualBox: I'm running out of space on my disk image. What now?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can resize your VirtualBox disk image. Instructions can be found on the
web, such as at http://www.midwesternmac.com/blogs/jeff-geerling/resizing-virtualbox-disk-image .

Container problems
------------------

Cannot reach the public internet from a container running UBOS
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this case, chances are that your host operating system is not correctly configured for
networking containers. Here is a list of things to check:

1. On your host, a new network interface is generated just for the UBOS container. Using:

   .. code-block:: none

      % ip addr

   check that such an interface appears when you create the container, and it
   has a suitable IP address such as ``10.0.0.1``. If not, check that you are running
   ``systemd-networkd`` on the host with a suitable configuration file.

2. In your UBOS container, using:

   .. code-block:: none

      % ip addr

   make sure your container has a corresponding
   IP address such as ``10.0.0.2``. If not, check that you are running
   ``systemd-networkd`` on the host with a suitable configuration file.

3. Test that you can ping the container from the host, and the host from the container with
   a command such as:

   .. code-block:: none

      % ping 10.0.0.1

   If you can't and both host and container have correct IP addresses,
   make sure your host does not run a firewall that prevents the communication from
   happening.

4. If the container can communicate with the host, and the host with the public internet,
   but the container cannot communicate with the public internet, chances are that
   some of the involved network interfaces aren't forwarding packets. This is common because
   most Linux distros deactivate packet forwarding by default. The simplest way to
   globally switch on packet forwarding on the host is to execute:

   .. code-block:: none

      % sudo sysctl net.ipv4.ip_forward=1

"I need help"
-------------

Come find us `here </community/>`_ and ask. We don't bite. At least not
if we had breakfast.

