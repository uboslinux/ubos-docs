``ubos-admin createsite``
=========================

See also :doc:`../../users/ubos-admin`.

This command is only a very shallow wrapper around :doc:`deploy` which:

* creates a :doc:`../site-json` file from information provided interactively by the user
  on the terminal;
* optionally, generates an openssl key pair and a self-signed certificate and inserts
  those into the :doc:`../site-json` file;
* optionally, obtains a Letsencrypt SSL/TLS certificate. Due to the way Letsencrypt
  operates, this only works on devices that have a publicly accessible IP address
  and public DNS has been set up to resolve the hostname of the to-be-created site
  to that device.
* deploys the generated :doc:`../site-json` file using :doc:`deploy`.

It exists to make it easier for new users to successfully deploy an app to their device
without having to edit Site JSON files directly.
