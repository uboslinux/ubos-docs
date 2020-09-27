Run UBOS on ODROID-XU4 and ODROID-HC2
=====================================

You can run UBOS on the ODROID devices of the XU3/XU4 family, which currently include:

* `ODROID-HC2 <https://www.hardkernel.com/shop/odroid-hc2-home-cloud-two/>`_
* `ODROID-XU4 <https://www.hardkernel.com/shop/odroid-xu4-special-price/>`_

by downloading an image, writing it to an SD card, and booting your ODROID device with that card.
(Alternatively you can keep running your existing Linux distro on your ODROID device, and
run UBOS in a Linux container. This is :doc:`described here <armv7h_container>`.)

Note that ODROID offers a variety of devices with a variety of rather different processors.
The instructions on this page are unlikely to work on any other ODROID devices than the ones
listed here.

#. Download a UBOS boot image from ``depot.ubos.net``.
   Images for the ODROID-XU3/XU4 family are at
   `http://depot.ubos.net/green/armv7h/images <http://depot.ubos.net/green/armv7h/images>`_.
   Look for a file named ``ubos_green_armv7h-odroid-xu3_LATEST.img.xz``.

#. Optionally, you may now verify that your image downloaded correctly by following the instructions
   at :doc:`verifying`.

#. Uncompress the downloaded file. This depends on your operating system, but might be as easy as
   double-clicking it, or executing

   .. code-block:: none

      % sudo xz -d ubos_green_armv7h-odroid-xu3_LATEST.img.xz

   on the command line.

#. Write this image file "raw" to an SD card appropriate for your ODROID device. This
   operation depends on your operating system:

   * :doc:`/users/writing-image/windows`
   * :doc:`/users/writing-image/macosx`
   * :doc:`/users/writing-image/linux`

#. Create a :doc:`UBOS Staff <../shepherd-staff>` if you haven't already. This is required
   for devices that don't have video, because UBOS does not permit login over the network
   with a publicly known password. Instead, the UBOS Staff mechanism allows you to use
   an SSH key pair that only you have access to.

#. Remove the SD card and insert it into your ODROID device. Insert the UBOS Staff into
   a USB port of your ODROID device.

#. Connect Ethernet networking to your ODROID device.

#. Connect the power supply to your ODROID device.

#. There isn't any indication when the boot process has finished, so you may want to
   simply wait for, say, 10 minutes.

#. Log into your ODROID device over the network as described :doc:`here <../shepherd-staff>`.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      % sudo ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
