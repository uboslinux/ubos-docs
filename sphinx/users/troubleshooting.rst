Troubleshooting
===============

Installation or boot problems
-----------------------------

On a PC: cannot boot UBOS from boot stick
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Q**: I have created a boot stick for x86_64 per instructions :doc:`here <installation/x86_bootstick>`.
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

On a PC: UBOS boot starts out fine, but then the screen goes blank
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Q**: I am booting UBOS on a PC. The grub bootloader comes up and starts "UBOS Linux".
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
first hard drive, say::

   ubos-install /dev/sda --additionalkernelparameter video=LVDS-1:d

This will put the incantation into the grub setting permanently.

On any device: nothing happens when UBOS is supposed to be booting
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Chances are, your boot stick or SD card (depending on the device you are using)
is bad, or writing the UBOS disk image to the card wasn't successful. This unfortunately
happens. We recommend you write the image on the disk or stick again, and try again.
If that fails, try a different boot stick or SD card.

Image problems
--------------

In VirtualBox: I'm running out of space on my disk image. What now?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can resize your VirtualBox disk image. Instructions can be found on the
web, such as `here <http://www.midwesternmac.com/blogs/jeff-geerling/resizing-virtualbox-disk-image>`_.

"I need help"
-------------

Come find us `on IRC <http://ubos.net/community/>`_ and ask. We don't bite.
