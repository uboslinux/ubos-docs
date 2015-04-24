``ubos-admin createsite``
=========================

See also :doc:`../../users/ubos-admin`.

This command is only a very shallow wrapper around :doc:`deploy` which:

* creates a :doc:`../site-json` file from information provided interactively by the user
  on the terminal
* optionally, generates an openssl key pair and a self-signed certificate and inserts
  those into the :doc:`../site-json` file
* deploys the generated :doc:`../site-json` file using :doc:`deploy`.

It exists to make it easier for new users to successfully deploy an app to their device
without having to edit Site JSON files directly.

