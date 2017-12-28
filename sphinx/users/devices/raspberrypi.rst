Raspberry Pi (any model)
========================

How to use a USB disk as the primary disk
-----------------------------------------

There's a `rumor <https://forum.ubos.net/viewtopic.php?f=2&t=4#p6>`_ that the Raspberry Pi 3
can boot directly from a USB disk without needing an SD Card at all. We have not tried this, and
it apparently only works for the Raspberry Pi 3.

The following works for all Raspberry Pi models: boot from the SD card, but switch over
to the USB disk as soon as possible and ignore it from that point. To do that:

#. Boot your Raspberry Pi from an SD card that has UBOS installed as described
   in :doc:`../installation/raspberrypi` or :doc:`../installation/raspberrypi2`.

#. Connect your external USB disk to your Raspberry Pi and turn it on.

#. Verify that UBOS has recognized the external disk by executing ``lsblk``. It should show your
   drive with a name such as ``/dev/sda``. It might be helpful to compare the output of the
   command with the drive turned off and turned on.

#. Install UBOS on the USB disk with a command such as ``ubos-install /dev/sda``.

   .. warning:: Make sure you get the device name right, otherwise you might accidentally
      destroy the data on some other hard drive!

   .. warning:: This will destroy all existing data on your
      USB disk, so make sure you want to do this.

#. After the command completes, edit file ``/boot/cmdline.txt``. Look for where it currently
   says something like ``/dev/mmcblk0p2`` (identifying the root partition on the SD Card) and
   change it to ``/dev/sda2`` (the root partition on the USB disk). Note: depending how
   exactly you installed UBOS on the SD card and the USB disk, the device names might be
   different; this page reflects the default.

#. Execute ``reboot``.

#. Once the system has rebooted, log in as ``root`` and check that your root disk is now
   ``/dev/sda2`` by executing ``lsblk``.

Bonus: edit ``/etc/fstab`` to mount the SD Card's first partition as ``/boot``. That way UBOS
updates can update the boot parameters on your SD Card in the future.

How to use the Raspberry Pi's camera
------------------------------------

Using the Raspberry Pi's official camera while running UBOS is quite simple, as everything
you need is pre-installed on UBOS for the Raspberry Pi.

However, you need to make one change in one file, which is to allocate more of the
Pi's limited memory to graphics. We could have pre-configured that, but we figure most
people running the Pi do not use a camera, and much rather have access to all of the RAM.

To make this change, become root and open the file with your favorite editor, such as
``vi``:

.. code-block:: none

   > sudo su
   # vi /boot/config.txt

Add the very end of the file, add the following content:

.. code-block:: none

   gpu_mem_512_=128
   gpu_mem_256_=128
   start_file=start_x.elf
   fixup_file=fixup_x.dat

(In ``vi``, you would hit ``G`` to go to the end of the file, then hit ``A`` to append,
then type the above text. When done, hit Escape to leave editing mode, and ``ZZ`` to save
and quit the editor.)

Then, shutdown your Pi:

.. code-block:: none

   > sudo shutdown -h now

and physically connect the camera to the Pi with the appropriate cable. Re-apply power,
and once the Pi has booted, you can take a picture with:

.. code-block:: none

   `/opt/vc/bin/raspistill -o mypicture.jpg`

or take a video with:

.. code-block:: none

   `/opt/vc/bin/raspivid -o myvideo.mpg`.

Invoke those commands without arguments to see their many options.
