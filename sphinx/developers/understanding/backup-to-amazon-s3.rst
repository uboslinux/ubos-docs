``ubos-admin backup-to-amazon-s3``
==================================

See also :doc:`../../users/ubos-admin` and :doc:`backup`.

This command performs essentially the same action as ``ubos-admin backup``, followed by:

* accessing the user's Amazon Web Services S3 account, using the credentials
  provided to it when first run. This credentials are stored at
  ``/etc/amazons3/aws-config-for-backup``;

* creating an S3 bucket if specified;

* uploading the backup file to the specified S3 bucket;

* deleting the local file.

Optionally, the command can, beforing uploading, first encrypt the backup using GPG
with a key pair available in the user's default GPG key store and identified on the
command-line.

Note that this command is not installed by default but contained in optional
package ``amazons3``.

This command must be run as root (``sudo ubos-admin backup-to-amazon-s3``).

See also: :doc:`restore`.
