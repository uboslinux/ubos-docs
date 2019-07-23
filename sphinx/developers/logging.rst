Logging
=======

Things may go wrong. It's computers, after all. If a log exists, developers and/or
users have a chance of figuring out what happened, and fix whatever the problem was.
Without such logs, life can be very frustrating. So, let's log!

Analyzing what happened on a user's device is easier if all code on that device
uses single logging facility. If a problem occurs due to an unexpected interaction
between two different components, for example, a single log has all events in
chronological sequence and debugging is much easier.

Log levels
----------

By default, all packages, :term:`Apps <App>` and :term:`Accessories <Accessory>` should
log warnings, errors and above. They should not log informational, debug-level or other
low-level messages.

It should be documented how it is possible to temporarily change the level of logging,
e.g. to assist the user with diagnosing and resolving a problem.

Journald-based logging
----------------------

UBOS uses the logging facilities provided by ``systemd``'s ``journald``. All packages,
:term:`Apps <App>` and :term:`Accessories <Accessory>` are strongly encouraged to use them.

You can find a few excellent introductions to logging via systemd on-line, e.g.

* `Using the Journal <http://0pointer.de/blog/projects/journalctl.html>`_ and
* `Logging to the Journal <http://0pointer.de/blog/projects/journal-submit.html>`_.

For general information about systemd, see the
`Systemd home page <http://freedesktop.org/wiki/Software/systemd/>`_.

When logging, developers are encouraged to provide as much contextual information as
needed to understanding the context of the message, in particular the :term:`AppConfigId`
of the installation that the log message refers to. The syslog identifier should be
set to the name of the reporting package.

If Journald-based logging is not possible
-----------------------------------------

Sometimes it is not possible to use ``systemd``'s ``journald``. For example, a web
server might log every request, and that would overwhelm the journal.

In this case, an :term:`App` or :term:`Accessory` should:

* write log files into directory ``/ubos/log/<dir>``, where ``<dir>`` is the name of the
  package, plus hyphen, plus :term:`AppConfigId`.

  For example, if the name of the :term:`App` is ``myapp`` and it has been deployed to
  :term:`AppConfiguration` ``a1234567890``, it should write its log files into directory
  ``/ubos/log/myapp-a123456789``.

* set up a ``logrotate`` policy that prevents those log files from growing endlessly.
  This is as simple as writing a file to ``/etc/logrotate.d``.

* cleanly close log files upon a log rotation event.

In case of a package that logs but that is not uniquely associated with an :term:`AppConfigId`,
it should:

* write log files into directory ``/ubos/log/<dir>``, where ``<dir>`` is the name of the
  package. For example, if the name of the package is ``mydbserver``, it should write its
  log files into directory ``/ubos/log/mydbserver``.

* it also needs to set up a ``logrotate`` policy and cleanly close log files upon
  rotation.

Here is an example for the Apache web server's ``logrotate`` policy, located in
``/etc/logrotate.d/httpd``:

.. code-block:: none

   /var/log/httpd/*log {
       missingok
       sharedscripts
       compress
       postrotate
           /usr/bin/systemctl reload httpd.service 2>/dev/null || true
       endscript
   }

You can see that in this configuration, log files will be compressed to save space,
and after a rotation has been performed, the web server is cleanly restarted.
