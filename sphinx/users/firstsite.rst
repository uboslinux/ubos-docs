Setting up your first web app
=============================

Follow these steps:

#. Decide which web app to install. You can find the current set of available apps
   `here <http:/apps/>`_. In this example, we'll use Wordpress.

#. Decide at which URL you'd like to run the app.  In this example, we'll
   use host ``*`` and run Wordpress at relative path ``/blog``. By specifying ``*``,
   meaning "any", you have the most choices for which URL will work in your browser
   to access your new Wordpress installation:

   * you can use the IP address of your UBOS device. For example, if the IP address
     is ``192.168.1.10``, Wordpress will be reachable at ``http://192.168.1.10/blog/``

   * UBOS devices now use mDNS to advertise themselves on the network. The name depends
     on the type of device:

     * if installed on a PC, Wordpress will be reachable at ``http://ubos-pc.local/blog/``

     * if installed on a Raspberry Pi, Wordpress will be reachable at ``http://ubos-rpi.local/blog/``

     Unfortunately that only works on older versions of Windows if you have iTunes installed.
     It should work on all other devices out of the box, including Macs, Linux PCs, iOS and
     Android devices.

   * If your UBOS device has an official DNS entry on its own, you should use this one, because
     if gives you the opportunity to run multiple sites (with their own distinct apps) on
     the same device, like web hosting companies do with virtual hosting.

   See also :doc:`networking`.

#. As root, execute the following command:

   .. code-block:: none

      > ubos-admin createsite

   This command will ask a number of questions. Once you have answered them, it will
   appear to think for a while and then set up your new app. Here is an example transcript:

   .. code-block:: none

      > sudo ubos-admin createsite
      App to run: wordpress
      Hostname for app: *
      App wordpress suggests context path /blog
      Enter context path: /blog
      Any accessories for wordpress? Enter list:
      Site admin user id (e.g. admin): admin
      Site admin user name (e.g. John Doe): admin
      Site admin user password (e.g. s3cr3t): .
      Site admin user e-mail (e.g. foo@bar.com): root@localhost

#. Access your new app. You can reach it directly by visiting the correct URL as described above.
   If you leave out the trailing ``/blog/``, you will see the list of apps installed at this
   site. Currently that is only Wordpress at path ``/blog/``, but you might want to add
   more apps later.

If you are curious what UBOS just did under the hood, please refer to
:doc:`/developers/understanding/createsite`.

