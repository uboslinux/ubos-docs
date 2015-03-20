How to make an app available on UBOS
====================================

If you have an app that you'd like to make available to UBOS users, here is the steps
you need to take:

#. Say "Hi" on the `mailing list or on IRC </contact/>`_. We don't bite, and might even be
   helpful!

#. Set up a :doc:`build machine <develop-in-virtualbox>`.

#. Package your app using ``makepkg``, with a ``PKGBUILD`` file and a
   :doc:`ubos-manifest`, as explained in :doc:`toyapps`.

#. Test that your app plays nicely on UBOS with :doc:`webapptest <app-test>`.

#. Augment the list of UBOS build files `here <https://github.com/uboslinux/ubos-buildconfig/tree/master/config/hl/us>`_,
   and file a pull request, so your app gets built and tested by the official UBOS build.

