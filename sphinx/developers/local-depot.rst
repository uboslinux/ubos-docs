Using up a local depot
======================

Usually, a UBOS installation pulls software packages from `http://depot.ubos.net/'.
However, during development and testing, it may be advantageous to run a local
depot on a build machine.

Setting up a depot container
----------------------------

To set this up, follow these steps:

#. Go to the `ubos-buildconfig` directory.

#. Create an ssh keypair you will use to upload new packages to the depot, e.g.::

      mkdir local.ssh
      ssh-keygen

   Enter a filename such as `local.ssh/id_rsa` and no passphrase.

#. Create a systemd service file that will start the `depot` container correctly.
   Depending on your needs, you may use different values. Here is an example that
   uses the host's `/home/buildmaster/UBOS-STAFF-DEPOT` as the container's UBOS Staff, so
   you can log in via ssh afterwards. We save it as
   `/etc/systemd/system/systemd-nspawn@depot.service`::

      # systemd .service file for starting a UBOS depot container, modify as needed
      # compare with /usr/lib/systemd/system/systemd-nspawn@.service

      [Unit]
      Description=Local UBOS depot
      Documentation=man:systemd-nspawn(1)
      PartOf=machines.target
      Before=machines.target
      After=network.target

      [Service]
      ExecStart=/usr/bin/systemd-nspawn --quiet --keep-unit --boot \
              --link-journal=try-guest --network-veth --machine=%I \
              --bind /home/buildmaster/UBOS-STAFF-DEPOT:/UBOS-STAFF
      KillMode=mixed
      Type=notify
      RestartForceExitStatus=133
      SuccessExitStatus=133
      Slice=machine.slice
      Delegate=yes

      # Enforce a strict device policy, similar to the one nspawn configures
      # when it allocates its own scope unit. Make sure to keep these
      # policies in sync if you change them!
      DevicePolicy=strict
      DeviceAllow=/dev/null rwm
      DeviceAllow=/dev/zero rwm
      DeviceAllow=/dev/full rwm
      DeviceAllow=/dev/random rwm
      DeviceAllow=/dev/urandom rwm
      DeviceAllow=/dev/tty rwm
      DeviceAllow=/dev/net/tun rwm
      DeviceAllow=/dev/pts/ptmx rw
      DeviceAllow=char-pts rw

      [Install]
      WantedBy=machines.target

#. Make sure the `/home/buildmaster/UBOS-STAFF-DEPOT` directory exists (if you chose the
   above configuration) and contains the following information::

       mkdir -p /home/buildmaster/UBOS-STAFF-DEPOT/shepherd/ssh
       ssh-keygen

   Specify `/home/buildmaster/UBOS-STAFF-DEPOT/shepherd/ssh/id_rsa` as the filename,
   and no password. You could reuse the above keypair, too, if you'd like to, but the
   `id_rsa.pub` file needs to be in that directory, so UBOS can configure the
   `shepherd` account correctly. (The private key doesn't need to be there.)

#. Boot a UBOS container that will become the local depot. This requires that you have
   a UBOS tarball available, e.g. from downloading or :doc:`rebuilding`. Let's assume we use
   `ubos_dev_container-pc_LATEST.tar`::

      sudo machinectl import-tar ubos_dev_container-pc_LATEST.tar depot
      sudo machinectl start depot

#. Login as shepherd with the private key of the keypair whose public key ended up
   in the `UBOS-STAFF` directory::

      ssh shepherd@depot -i /home/buildmaster/UBOS-STAFF-DEPOT/shepherd/ssh/id_rsa

   and install a locally built `ubos-depot` package, unless you want the default from
   the default UBOS depot at `http://depot.ubos.net/`. You may want a locally built version
   if the container you are booting uses an image you built yourself; otherwise version
   inconsistencies between standard UBOS and your build may occur.

   You can copy the package file from the host to the container with `scp`, or
   `machinectl copy-to`. Then, in the container::

      sudo pacman -U --noconfirm ...path...to.../ubos-repo...pkg.tar.xz

#. Set up the depot website::

      sudo ubos-admin createsite

   Enter `ubos-repo` as the name of the app, `depot` as the hostname, and paste the
   content of the host's `local.ssh/id_rsa.pub` (that you created earlier) into the
   field where it asks for a public upload ssh key. Pick whatever admin account information,
   it does not matter in this case.

# You should now be able to reach `http://depot/` from the host. (Note: by default, the front
  page redirects to `http://ubos.net/`) If you cannot reach it, check your container setup.
  On the host, as root:

     echo 0 > /proc/sys/net/ipv4/ip_forward
     echo 1 > /proc/sys/net/ipv4/ip_forward

  and make sure `/etc/nsswitch.conf` contains `mymachines` in the `hosts` section.

Uploading built packages to the local depot
-------------------------------------------

On your Arch build machine, go back to the `ubos-buildconfig` directory. Edit (or create)
the `local.mk` file, so it has these lines::

   UPLOADDEST=ubos-repo@depot:
   UPLOADSSHKEY=local.ssh/id_rsa

This will instruct make's `upload` target to upload packages and images to the host
`depot` (i.e. the container you created above), using `ubos-repo` as the username, and
and the ssh key you created earlier. User `ubos-repo` was automatically created when you
installed package `ubos-repo` on the `depot` container. The upload will be performed
using `rsync` over `ssh`; hence the syntax for `UPLOADDEST`.
