Overview: How to make an App available on UBOS
==============================================

If you have an :term:`App` that you'd like to make available to UBOS users, it is recommended
you do this:

#. Say "Hi" in the `forum </community/>`_. We don't bite, and might even be
   helpful :-)

#. Set up a :doc:`development machine <setting-up-development-machine>`.

#. Package your :term:`App` using ``makepkg``, with a ``PKGBUILD`` file and a
   :doc:`ubos-manifest`. You can find examples in :doc:`toyapps`, and documentation
   in other sections of this site.

#. Test that your :term:`App` plays nicely on UBOS with :doc:`webapptest <app-test>`.

#. Augment the list of UBOS build files `here <https://github.com/uboslinux/ubos-buildconfig/tree/master/hl/us>`_,
   and file a pull request, so your :term:`App` gets built and tested by the official UBOS build.

Done!
