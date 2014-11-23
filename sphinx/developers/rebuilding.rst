Rebuilding UBOS for yourself
============================

If you are paranoid, and wish to rebuild UBOS from scratch, follow these steps:

#. You need a build system running `Arch Linux <http://archlinux.org/>`_ on
   the processor architecture that you like to use.

   For example, you can spin up an Amazon EC2 instance running Arch Linux x86 by
   starting a suitable image from
   `Uplink Labs <https://www.uplinklabs.net/projects/arch-linux-on-ec2/>`_.
   Allocate at least 8GB of disk, preferably more. (For how to configure an
   EC2 instance, please refer to
   `Amazon's documentation <http://aws.amazon.com/ec2>`_.)

   Alternatively, you could use a spare physical x86 server, or a virtual machine
   with virtualization software such as VirtualBox, VMWare, Xen and so forth.
   Installation instructions for Arch Linux can be found on the
   `Arch Linux wiki <https://wiki.archlinux.org/index.php/Installation_Guide>`_.

   If you are building for ARM, it's easiest to install Arch Linux on your
   ARM device with an image from the
   `Arch Linux ARM project <http://archlinuxarm.org/>`_.

   Whichever method you used to get an Arch system set up, when you have it
   working, log in as root.

#. Update the Arch Linux package database::

      root> pacman -Syu

#. Create a non-root build user, e.g.::

      root> useradd -m buildmaster
      root> passwd buildmaster

   This build user should be able to ``sudo`` many commands. For example, image generation
   requires mounting drives and creating files owned by root. It is easiest if you allow
   the build user to execute any command as root. To do that, first make sure ``sudo``
   is installed::

      root> pacman -S sudo

   Then create file ``/etc/sudoers.d/buildmaster`` with the following content::

      buildmaster ALL = NOPASSWD: ALL

   Make sure the permissions are correct::

      root> chmod 600 /etc/sudoers.d/ubos

   If you access your build machine primarily over the network, we recommend you
   set up key-based ssh login for the build user::

      root> mkdir ~buildmaster/.ssh
      root> cat > ~buildmaster/.ssh/authorized_keys

   Paste a suitable ssh public key into your shell, e.g. one you got from running
   ``ssh-keygen`` on your local machine. You may already have one on your local
   machine in ``~/.ssh/id_rsa.pub``. You can paste that one in.

   Then, on the build machine, correct the permissions of the newly created files::

      root> chown -R buildmaster:buildmaster ~buildmaster/.ssh
      root> chmod 0700 ~buildmaster/.ssh
      root> chmod 0600 ~buildmaster/.ssh/authorized_keys

   Log off as root, and re-login as the build user. You now should be able to say::

      buildmaster> sudo whoami
      root

   From now on, we will execute all commands as the build user, and use ``sudo``
   when we need more privileges.

#. Install the build tools.

   We need to install some tools from official Arch repositories::

      buildmaster> sudo pacman -S --noconfirm base-devel git libaio php mariadb perl-dbd-mysql perl-www-curl dosfstools

   If you are on an x86 platform, you also need to::

      ubos> pacman -S --noconfirm virtualbox grub

   On ARM, you also need to::

      ubos> sudo pacman-key --init
      ubos> sudo pacman -S archlinuxarm-keyring

   One tool we need is only in the
   `Arch User Repository (AUR) <https://aur.archlinux.org/>`_::

      buildmaster> mkdir -p ~/aur
      buildmaster> cd ~/aur
      buildmaster> curl -L -O https://aur.archlinux.org/packages/mu/multipath-tools/multipath-tools.tar.gz
      buildmaster> tar xfz multipath-tools.tar.gz
      buildmaster> cd multipath-tools
      buildmaster> makepkg -c -f -A

   This last command will take a bit as the package has to be compiled. It does print a
   bunch of compiler warnings; hopefully somebody will fix this upstream some day. But
   it seems to work for us.

   Then install the package. We use a * here as the version of this package might have
   changed since we wrote this page::

      ubos> sudo pacman -U --noconfirm multipath-tools-*.pkg.tar.xz

   Now, the UBOS tools. For that, we use git::

      buildmaster> mkdir -p ~/git/github.com/indiebox
      buildmaster> cd ~/git/github.com/indiebox
      buildmaster> git clone https://github.com/indiebox/ubos-buildconfig

#. Now we can build. This will install a few more tools as part of the process.
   Make sure to enter the backslashes as the last character in the line, or leave out
   the backslashes and do not break the line::

      buildmaster> cd ~/git/github.com/indiebox/ubos-buildconfig
      buildmaster> make -f Makefile.dev \
           IMPERSONATEDEPOT= \
           code-is-current build-packages

   This command may take a while, mostly depending on the speed of your internet connection,
   the speed of the mirror that you chose, and, of course the speed of your device.
   But when it is done, the UBOS repositories will be at ``~/repository/dev``

#. To create boot images, continue by executing the following command::

      buildmaster> cd ~/git/github.com/indiebox/ubos-buildconfig
      buildmaster> make -f Makefile.dev \
           IMPERSONATEDEPOT= \
           code-is-current build-images

To use your freshly built UBOS, refer to :doc:`/users/installation`, using your created
boot image instead of the one downloaded from ubos.net, and pointing ``/etc/pacman.conf``
to the packages you built.
