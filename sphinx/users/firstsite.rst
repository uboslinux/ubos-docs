Setting up your first web app
=============================

Follow these steps:

#. Decide which web app to install. In this example, we'll use Wordpress.

#. Decide at which URL the web app will be installed. In this example, we'll
   use host ``family.example.com`` and run Wordpress at relative path ``/blog``.

#. Execute the following command::

      > sudo ubos-admin createsite

   This command will ask a number of questions. Once you have answered them, it will
   appear to think for a while and then set up your new app. Here is an example transcript::

      > sudo ubos-admin createsite
      App to run: wordpress
      Hostname for app: family.example.com
      App wordpress suggests context path /blog
      Enter context path: /blog
      Any accessories for wordpress? Enter list:
      Site admin user id (e.g. admin): admin
      Site admin user name (e.g. John Doe): admin
      Site admin user password (e.g. s3cr3t): .
      Site admin user e-mail (e.g. foo@bar.com): root@localhost

#. Access your new app. You can reach it directly by visiting ``http://family.example.com/blog/``, or
   you can see the list of apps installed at host ``http://family.example.com/``, and select Wordpress
   from there.

If you are curious what UBOS just did under the hood, please refer to
:doc:`/developers/understanding/createsite`.

.. note:: About DNS

   You may want to use mDNS/zeroconf.

   If your host is a PC, for example, it will be reachable by most browsers / clients
   at URL ``http://ubos-pc.local/``. You may want to specify that name as the hostname
   in the ``createsite`` command above, and you save yourself DNS setup. To determine the
   hostname, execute ``hostname`` on the commandline, or use a mDNS browser.

   Alternatively, you can manually set up DNS with your router, your DNS server or such,
   depending on your network configuration.
