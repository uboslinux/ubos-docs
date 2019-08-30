Release Notes: Update 2019-08-30
================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --backuptodirectory ~``

(Note that after this update, you also need to specify ``--all``; see below.)

Then, update your device:

* ``sudo ubos-admin update -v``

Please refer to the main documentation for details.

New and improved functionality for users:
-----------------------------------------

* Command ``ubos-admin status`` has become much more useful, for users to determine the
  health of their device, and to make customer support simpler. Specifically:

  * by default, it shows a summary of all there is to know about the device, such as
    the type of the device, which disks are attached, how much space is used on those
    disks, when the device was last updated, and whether there are any known problems
    with the device.

  * optional flags (such as ``--problems``) allow to easily zoom into specific
    areas.

* Backups have become faster, as UBOS now applies a heuristic on which files to compress
  and which to use as-is in the backup file, as some file formats are compressed already.

* Integration with the `LetsEncrypt <https://letsencrypt.org/>`_ certificate authority
  has been significantly improved, and various bugs have been fixed:

  * When we tested a LetsEncrypt-protected site running on UBOS with the tools provided
    by `SSL Labs <https://www.ssllabs.com/>`_, we obtained an "A" rating. All other
    LetsEncrypt-protected sites running on UBOS should, too, after this upgrade.

  * When backing up a LetsEncrypt-protected site, it can be easily restored to a different
    hostname: UBOS will automatically obtain a certificate for the new hostname.

  * When undeploying LetsEncrypt-protected sites, UBOS now stashes still-valid certificates,
    and reuses them when such a Site is redeployed on the same device. This avoids
    running into rate-limiting features by LetsEncrypt that you may encounter when
    performing many systems administration tasks in a rapid sequence, for example.

  * UBOS will not use an expired LetsEncrypt certificate to deploy a Site, or to restore
    a Site from backup; instead it will provision a new one.

  * Renewal of expiring certificates is now in-place, requiring no more manual steps.

  * UBOS now also automatically serves intermediate LetsEncrypt certs.

* Integration with `Pagekite <https://pagekite.net/>`_ for accessing a UBOS device behind
  a firewall has been further improved:

  * Pagekite secrets can now be specified interactively.

  * Wildcard sites (like the one we ship with
    `UBOSbox Nextcloud <https://indiecomputing.com/products>`_) are now supported.

* Backing up with ``ubos-admin backup`` has been improved:

  * Either the Site(s) or ``--all`` must be specified when backing up. This avoids
    the frequent user mistake of accidentally backing up all Sites on a multi-Site
    device by forgetting to specify which Site (only) was supposed to be backed up.

  * The new ``--resolve`` flag, inherited from ``curl``, makes backing up over the
    network without official DNS entries (e.g. on a home LAN) much simpler.

  * The upload to a network destination phase of ``ubos-admin backup`` (after the backup
    to a local file stage is complete) no longer prevents the invocation of
    other ``ubos-admin`` commands.

* ``ubos-admin showsite`` has learned new tricks:

  * with argument ``--adminuser``, information about the Site administrator is shown.
    This makes it easy to find out, for example, what the administrator username and
    password is for a deployed app like Nextcloud.

  * Credentials and private customizationpoint values are not shown any more default. To
    see them, you need to explicitly specify argument ``--credentials`` or
    ``--privatecustomizationpoints``.

* ``ubos-admin showappconfig`` now also shows which Site the AppConfiguration belongs to.

* ``ubos-admin deploy --template`` can now automatically generate self-signed
  certificates if an empty ``"tls" : {}`` is provided in the Site JSON template.

* ``ubos-admin listsites --html`` emits HTML.

* ``ubos-admin createsite`` can now use a Site JSON template file as a template, and
  will ask the user only about those values that aren't already provided.

* ``ubos-install`` will refuse to install to a mounted disk. However, it will now
  install to the target of a symbolic link. This makes installations more predictable
  by supporting destinations such as below ``/dev/disk/by-path``.

* The UBOS Staff now lists the devices first that were most recently updated.

* Logging in via ``ssh`` now presents the UBOS banner.

* The VirtualBox image is now larger.

* UBOS boots without the ``quiet`` kernel option. For the UBOS use cases, seeing more
  information during boot is better rather than less.

* The output of some ``ubos-admin`` commands, such as ``ubos-admin showsite`` has become
  more concise; additional flags make it more verbose.

* Improved progress messages.

* Various documentation improvements.


New and improved functionality for developers:
----------------------------------------------

* Apps can now require TLS by saying so in the UBOS Manifest. This makes it impossible
  to deploy the App to a Site not protected by (official, or self-signed) TLS.

* Customizationpoints can now be of type ``float`` in addition to the previously
  available types.

* Customizationpoints can be marked as ``internal``, and if so, will not be shown to the
  user by default. That reduces user confusion and improves security related to
  customizationpoints such as password salts, or Redis credentials.

* Systemd service ``smtp-server@<appconfigid>.service`` is now available so that apps that require
  a local SMTP service can say so without interfering with each other.

* A defined conflict resolution strategy has been implemented for when two apps deployed
  to the same Site request the same entries in the Site's ``.well-known`` directory;
  depending on the entry, one takes preference over another, or the entries are merged.

* The ``generic`` Role in the UBOS manifest may now specify ``depends`` entries.

* By default, PHP allows access to both ``/tmp`` and ``/ubos/tmp``.

* The default Mariadb encoding is now ``utf8mb4``.

* The ``webapptest`` testing framework has new abilities:

  * Flag ``--tlsselfsigned`` runs the test over TLS with an automatically-generated,
    self-signed TLS certificate.

  * ``webapptest`` can now use Site JSON templates.

* ``pacsane`` now accepts relative path names.

Notable fixes:
--------------

* Some networks have slow DNS servers, and that has caused some ``iptables`` restarts
  to fail. This has been made more robust.

* Upgrades of deployed sites, or restores from backup now install new role dependencies
  declared in the manifest. They were previously ignored.

* Pagekite now works with wildcard Sites.

* WPA supplicant files are generated more defensively for higher user success with
  specifying WiFi credentials with the UBOS Staff.

Changes in shipped packages:
----------------------------

* The Apache webserver was upgraded.

* We only ship Node LTS, no other Node versions.

* Monero was removed.

* We removed the ``ruby-rails-blog`` example application for Ruby on Rails; ``decko``
  is better, real-world example.

* Each device class supported by UBOS has a pre-installed specific package, such as
  ``ubos-deviceclass-pc``.

* A patched version of LetsEncrypt test Certificate Authority ``pebble`` ships in
  ``os-experimental``. It issues certificates with a very short expiration time, to
  help with testing.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.

