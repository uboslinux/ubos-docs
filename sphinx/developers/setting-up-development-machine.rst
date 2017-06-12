Setting up a UBOS development machine
=====================================

For UBOS development, you can use:

* a spare x86_64 PC
* a virtual machine using VirtualBox or VMware on a Mac, PC or other Linux box
* a spare ARM-based device, like a Raspberry Pi. (Not recommended: see :doc:`FAQ <faq>`)

We recommend you use Arch Linux for UBOS development. Arch is very similar to UBOS, and
has a full range of development tools. To use Arch as the OS for UBOS development on one
of the above platforms, you need to:

1. Prepare the hardware, or virtual machine
2. Install Arch Linux
3. Add the UBOS tools
4. Optionally, run UBOS in a Linux container on that Arch host

Depending on your hardware choice, continue with the corresponding section below:

.. toctree::
   :maxdepth: 2

   prepare-arch-pc
   prepare-arch-virtualbox
   install-arch
   install-ubos-tools
   install-ubos-target-in-container
