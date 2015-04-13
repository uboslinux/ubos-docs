Perl scripts in UBOS manifests
==============================

Most application instrumentation in UBOS can be accomplished purely with
``ubos-manifest.json`` and template files that are parameterized with variable names.

Sometimes, however, a script is necessary. For that purpose, AppConfigItems and
installers/upgraders of type ``perlscript`` are provided, which allow developers to run
arbitrary fragments of Perl code during certain management tasks.
To run code in some other language, simply invoke that code from a Perl script using Perl's
``system()`` function or the like.

The Perl fragment will be executed by UBOS through Perls' ``eval`` method. Two
variables are being provided by the run-time context:

* ``$operation``: contains a text string that indicates the operation that is being
  applied, such as ``deploy``, ``undeploy``, ``install``, ``uninstall``, and
  ``upgrade``.
* ``$config``: a ``UBOS::Configuration`` object that contains contextual variables,
  included all of those described in :doc:`variables`.

Perl fragments typically look like this:

.. code-block:: perl

   #!/usr/bin/perl

   use strict;
   use warnings;

   my $dataDir = $config->getResolve( 'appconfig.datadir' );
       # or look up whatever variables are needed

   if( 'install' eq $operation ) {
       # do something
   }
   if( 'uninstall' eq $operation ) {
       # do something else
   }
   # potentially more possible values of $operation
   1;

For an example, refer to ``initialize.pl`` and ``upgrade.pl`` in the Wordpress package for UBOS.
Source code is `here <https://github.com/uboslinux/ubos-wordpress/blob/master/wordpress/bin>`_.

This ``initialize.pl`` script is used to generate the Wordpress ``config.php`` file from a script, instead
of from a file template, and to initialize Wordpress. ``upgrade.pl`` invokes the Wordpress data
migration functionality after a Wordpress upgrade.
