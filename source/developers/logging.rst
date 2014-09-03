Logging
=======

Things may go wrong. It's computers, after all. If a log exists, developers and/or users have a chance of figuring out what happened, and fix whatever the problem was. Without
such logs, life can be very frustrating. So, let's log!

It also turns out that it is advantageous to have a single logging facility used by all code on a device. If a problem occurs due to an unexpected interaction between two
different components, for example, a single log has all events in chronological sequence
and debugging is much easier.

UBOS uses the logging facilities provided by ``systemd``. All packages, apps and
accessories are encouraged to use them.

There are a few excellent introductions to logging via systemd, e.g.

 * `Using the Journal <http://0pointer.de/blog/projects/journalctl.html>`_ and
 * `Logging to the Journal <http://0pointer.de/blog/projects/journal-submit.html>`_

For general information about systemd, see the
`Systemd home page <http://freedesktop.org/wiki/Software/systemd/>`_.

When logging, developers are encouraged to provide as much contextual information as
needed to understanding the context of the message, in particular the :term:`appconfigid`
of the installation that the log message refers to. The syslog identifier should be
set to the name of the reporting package.
