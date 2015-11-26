Prepare a VirtualBox virtual machine to develop for UBOS using Arch Linux
=========================================================================

To set up an Arch Linux system for UBOS development in VirtualBox, first prepare
a suitable virtual machine:

#. `Download VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_ and install it
   if you haven't already.

#. Download a 64bit Arch Linux boot image from `here <https://www.archlinux.org/download/>`_
   and save it in a convenient place. You only need it for the installation and you can
   delete it later.

#. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS development". Select Type: "Linux", and
     Version: "Arch Linux (64 bit)". Click "Continue".

   * Select the amount of RAM you want to give it. 2048MB is a good start, and you can change
     that later. Click "Continue".

   * Select "Create a virtual hard drive now", and click "Create".

   * Select any of the types available for the new virtual hard drive. The default ("VDI")
     is fine. Click "Continue".

   * Select either "Dynamically allocated" or "Fixed size". While "Fixed size" might be slightly
     faster, "dynamically allocated" often uses significantly less space on your hard drive.
     Click "Continue".

   * Accept the default name for the virtual hard drive file. Pick a size that is sufficient
     for what you want to do. 16GB or more is recommended, particularly if you are planning
     to run a Linux desktop environment in your development virtual machine.

     If you selected "Dynamically allocated" in the previous step, the file containing your virtual
     hard drive will only grow to that size if you actually fill it with that much data.

     Click "Create".

#. Now start the virtual machine by selecting it in the sidebar, and clicking "Start".
   When it asks you, select the Arch Linux boot image ISO file that you downloaded earlier
   as the start-up disk. You need to select the little icon there to get a file
   selection dialog. Click "Start". The virtual machine should now be booting.

#. The Arch Linux boot loader has several options. The first one (``Boot Arch Linux (x86_64)``)
   is the one you want to select. Press the Return key.

Continue with :doc:`install-arch`.
