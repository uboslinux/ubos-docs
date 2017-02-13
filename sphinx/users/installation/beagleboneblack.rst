Run UBOS on Beagle Bone Black
=============================

You can run UBOS on your Beagle Bone Black by downloading an image, writing it to a micro SD card,
and booting your Beagle Bone Black with that card. (Alternatively you can keep running your
existing Linux distro on your Beagle Bone Black, and run UBOS in a Linux container.
This is :doc:`described here <armv7h_container>`.)

#. Download a UBOS boot image from `depot.ubos.net`.
   Beta images for the Beagle Bone Black are at
   `http://depot.ubos.net/yellow/armv7h/images <http://depot.ubos.net/yellow/armv7h/images>`_.
   Look for a file named ``ubos_yellow-bbb_LATEST.img.xz``.

#. Optionally, you may now verify that your image downloaded correctly by following the instructions
   at :doc:`verifying`.

#. Uncompress the downloaded file. This depends on your operating system, but might be as easy as
   double-clicking it, or executing

   .. code-block:: none

      > xz -d ubos_yellow-bbb_LATEST.img.xz

   on the command line.

#. Write this image file "raw" to a micro-SD card. This operation depends on your operating system:

   * :doc:`/users/writing-image/windows`
   * :doc:`/users/writing-image/macosx`
   * :doc:`/users/writing-image/linux`

#. On first boot, it is recommended you have a monitor and keyboard connected to your
   Beagle Bone Black. If this is impractical, create a :doc:`UBOS staff <../shepherd-staff>`
   so you can securely log in over the network without the need for monitor or keyboard.

#. Remove the micro-SD card and insert it into your Beagle Bone Black. If you created a UBOS staff,
   insert the staff into the USB port. Then, plug in the Beagle Bone Black's USB power.

#. When the boot process is finished, log in as user ``root`` from the attached keyboard
   and monitor. By default, there is no password on the console. If you used a UBOS staff,
   you can log in over the network instead as described :doc:`here <../shepherd-staff>`.

#. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes.
   To determine whether UBOS ready, execute:

   .. code-block:: none

      > systemctl is-system-running

   Wait until the output has changed from ``starting`` to ``running``. If it is anything else, consult
   :doc:`troubleshooting<../troubleshooting>`.

#. If you have Ethernet plugged in, and your network has a DHCP server (most networks do),
   your computer should automatically acquire an IP address. You can check with:

   .. code-block:: none

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
