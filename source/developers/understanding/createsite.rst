Understanding creating a new site
---------------------------------

This should be read in conjunction with :doc:`/users/firstsite`.

When you entered ``wordpress``, UBOS downloaded and examined the Wordpress package;
more specifically, the :term:`UBOS manifest JSON` of the Wordpress package. This
allowed UBOS to determine that Wordpress is a web application which prefers to run
on a virtual host (aka site) at relative path ``/blog``. It also determined that you
are able to override this path if you wish.

If you had entered any accessories, UBOS would also have downloaded those.

Because a new site needed to be set up, UBOS also asked for site administration
information, like site administrator name and e-mail address. We have found that
site maintenance is simpler if all applications at a site use the same administrator
name and password; this is why this is being asked here.

After you answered all the required questions, UBOS proceeded as follows:

 * It created a new Apache virtual host configuration, including Apache configuration
   files and corresponding directories.

 * It copied the required Wordpress PHP files to the web server directory corresponding
   to the above virtual host configuration.

 * It provisioned a MySQL database with the correct permissions.

 * It generated the ``wp-config.php`` file that Wordpress requires to connect to its
   database, and inserted the correct database information.

 * It restarted the Apache web server.

 * It automatically filled out and ran the Wordpress web installer, using the site
   administrator information you provided earlier.

 * It saved the configuration for this new site in a :term:`Site JSON` file. If
   you like to see all Site JSONs currently installed on your host, execute::

   > ubos-admin listsites --json
