Rebuilding UBOS for yourself
============================

If you are paranoid, and wish to rebuild UBOS from scratch, follow these steps:

#. Preferably, you rebuild UBOS on UBOS itself. Alternatively, you can set up
   an Arch Linux system with the UBOS tools as described in
   :doc:`setting-up-development-machine`.

#. Install package ``macrobuild-ubos``::

      > sudo pacman -S macrobuild-ubos

#. The user that you are running the build as must be able to ``sudo`` because image
   generations, mounting of loop devices etc requires root privileges.

#. Check out the UBOS build configuration and go to that directory::

      > git clone https://github.com/uboslinux/ubos-buildconfig

#. Create your our build settings file, or use the UBOS default::

      > git clone https://github.com/uboslinux/macrobuild-ubos
      > cd macrobuild-ubos

   You can overwrite settings in the ``settings.pl`` file by creating
   your own ``local.pl`` settings file.

#. Find out the list of available build targets::

      > macrobuild -l

#. Execute the target you'd like to execute. For example::

      > macrobuild build-dev -v

   will build the UBOS ``dev`` channel in verbose mode.

#. If you receive an error message about an undefined variable, you need to
   specify this variable either in your settings or on the command line.
   For example, to run the tests, you need to specify the channel which
   to test, like this::

      > macrobuild run-webapptests --channel dev

