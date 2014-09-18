Rebuilding UBOS for yourself
============================

If you are paranoid, and wish to rebuild UBOS from scratch, follow these steps:

#. You need a build system running `Arch Linux <http://archlinux.com/>`_.

   For example, you can spin up an Amazon EC2 instance running Arch Linux by
   starting a suitable image from
   `Uplink Labs <https://www.uplinklabs.net/projects/arch-linux-on-ec2/>`_.
   Allocate at least 8GB of disk, preferably more. (For how to configure an
   EC2 instance, please refer to
   `Amazon's documentation <http://aws.amazon.com/ec2>`_.)

   Alternatively, you could use a spare physical x86 server, or a virtual machine
   with virtualization software such as VirtualBox, VMWare, Xen and so forth.
   Installation instructions for Arch Linux can be found on the
   `Arch Linux wiki <https://wiki.archlinux.org/index.php/Installation_Guide>`_.

   Whichever method you used to get an Arch system set up, when you have it
   working, log in as root.

#. Update the Arch Linux package database::

      root> pacman -Syu

#. Create a non-root build user, e.g.::

      root> useradd -m ubos
      root> passwd ubos

   This build user should be able to ``sudo`` many commands. For example, image generation
   requires mounting drives and creating files owned by root. It is easiest if you allow
   the build user to execute any command as root. To do that, first make sure ``sudo``
   is installed::

      root> pacman -S sudo

   Then create file ``/etc/sudoers.d/ubos`` with the following content::

      ubos ALL = NOPASSWD: ALL

   Make sure the permissions are correct::

      root> chmod 600 /etc/sudoers.d/ubos

   If you access your build machine primarily over the network, we recommend you
   set up key-based ssh login for the build user::

      root> mkdir ~ubos/.ssh
      root> cat > ~ubos/.ssh/authorized_keys

   Paste a suitable ssh public key into your shell, e.g. one you got from running
   ``ssh-keygen`` on your local machine. You may already have one on your local
   machine in ``~/.ssh/id_rsa.pub``. You can paste that one in.

   Then, on the build machine, correct the permissions of the newly created files::

      root> chown -R ubos:ubos ~ubos/.ssh
      root> chmod 0700 ~ubos/.ssh
      root> chmod 0600 ~ubos/.ssh/authorized_keys

   Log off as root, and re-login as the build user. You now should be able to say::

      ubos> sudo whoami
      root

   From now on, we will execute all commands as the build user, and use ``sudo``
   when we need more privileges.

#. Install the build tools.
   We need to install some tools from official Arch repositories and the
   `Arch User Repository (AUR) <https://aur.archlinux.org/>`_::

      ubos> sudo pacman -S --noconfirm libaio php
      ubos> mkdir -p ~/aur
      ubos> cd ~/aur
      ubos> curl -L -O https://aur.archlinux.org/packages/mu/multipath-tools/multipath-tools.tar.gz
      ubos> tar xfz multipath-tools.tar.gz
      ubos> cd multipath-tools
      ubos> makepkg -c -f

   This last command will take a bit as the package has to be compiled. It does print a
   bunch of compiler warnings; hopefully somebody will fix this upstream some day. But
   it seems to work for us.

   Then install the package. We use a * here as the version of this package might have
   changed since we wrote this page::

      ubos> sudo pacman -U --noconfirm multipath-tools-*.pkg.tar.xz

   Now, the UBOS tools. For that, we need git::

      ubos> sudo pacman -S git
      ubos> mkdir -p ~/git/github.com/indiebox
      ubos> cd ~/git/github.com/indiebox
      ubos> for p in ubos-admin macrobuild macrobuild-ubos perl; do
      > git clone https://github.com/indiebox/$p
      > done
      ubos> for p in perl-log-journald; do
      > ( cd perl/$p; makepkg -c -f -s; sudo pacman -U --noconfirm $p-*pkg.tar.xz )
      > done
      ubos> for p in ubos-perl-utils ubos-admin; do
      > ( cd ubos-admin/$p; makepkg -c -f -s; sudo pacman -U --noconfirm $p-*pkg.tar.xz )
      > done
      ubos> for p in macrobuild macrobuild-ubos; do
      > ( cd $p; makepkg -c -f -s; sudo pacman -U --noconfirm $p-*pkg.tar.xz )
      > done

#. Now we can build. For that, we need the URL to an Arch Linux mirror from where we
   take already-built packages. Some choices are
   `here <https://wiki.archlinux.org/index.php/Mirror>`_.

   The following command needs to be a single line (or a backslash needs to be at the end
   of the line as shown). It will put the entire UBOS distribution together in the ``dev``
   channel. Replace ``$ARCHMIRROR`` with the URL to the Arch Linux mirror that you picked::

      ubos> macrobuild UBOS::Macrobuild::BuildTasks::BuildDev \
          --configdir ~/git/github.com/indiebox/macrobuild-ubos/config \
          --archUpstreamSite $ARCHMIRROR \
          --arch x86_64 \
          --builddir ~/build \
          --repodir ~/repository/dev

   If you want to see more of what is happening, add ``-v`` or even ``-v -v``.

   This command may take a while, mostly depending on the speed of your internet connection
   and the speed of the mirror that you chose.
   But when it is done, the UBOS repositories will be at ``~/repository/dev``

#. To create boot images, continue by executing the following command::

      ubos> macrobuild UBOS::Macrobuild::BuildTasks::CreateAllImages \
          --channel dev \
          --arch x86_64 \
          --repodir ~/repository \
          --imagedir ~/images \
          --adminSshKeyFile /etc/macrobuild-ubos/keys/ubos-admin.pub \
          --adminHasRoot 1

   Again, ``-v`` or ``-v -v`` will provide more build output. The passed-in file
   ``/etc/macrobuild-ubos/keys/ubos-admin.pub`` will be set as an
   authorized key that enables user ``ubos-admin`` to log on via ssh if the
   user specifies the corresponding private key.

   In this example invocation, we set it to the default public key that enables automatic
   administration; you can alternatively set it to any key you like.

   If you specify ``--adminHasRoot 1``, ``ubos-admin`` will be able to ``sudo``
   any command; otherwise only the command ``sudo ubos-admin`` but not, for example
   ``sudo bash``.

To use your freshly built UBOS, refer to :doc:`/users/installation`, using your created
boot image instead of the one downloaded from ubos.net, and pointing ``/etc/pacman.conf``
to the packages you built.
