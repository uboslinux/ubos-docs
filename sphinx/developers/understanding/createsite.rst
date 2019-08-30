``ubos-admin createsite``
=========================

See also :doc:`../../users/ubos-admin`.

This command is only a very shallow wrapper around :doc:`deploy` which:

* creates a :doc:`../site-json` file from information provided interactively by the user
  on the terminal;
* optionally, generates an openssl key pair and a self-signed certificate and inserts
  those into the :doc:`../site-json` file;
* optionally, obtains a LetsEncrypt SSL/TLS certificate. Due to the way LetsEncrypt
  operates, this only works on devices that have a publicly accessible IP address
  and public DNS has been set up to resolve the hostname of the to-be-created :term:`Site`
  to that device.
* deploys the generated :doc:`../site-json` file using :doc:`deploy`.
* if a template file is provided on the command line, the user will only be asked for
  information that is not already contained in the template file.

It exists to make it easier for new users to successfully deploy an :term:`App` to their device
without having to edit Site JSON files directly.

Unless the ``--dry-run`` command is given, this command must be run as root (``sudo ubos-admin createsite``).
