SMTP notes
==========

Many :term:`Apps <App>` need to send e-mail to their users, for purposes such as account
confirmations, password resets, or notification of certain events.

Sending e-mail is functionality provided by UBOS, and does not need to be performed on
an application level. Instead, the :term:`App` should simply send its outgoing e-mail
to the SMTP port on the local device.

In order to declare to UBOS that the :term:`App` wishes to do that, and to not interfere
with other :term:`Apps <App>` on the same device that may wish to do the same, it
should activate an :term:`AppConfigItem` of type ``systemd-service`` with the name
``smtp-server@<APPCONFIGID>.service`` where ``<APPCONFIGID>`` is the :term:`AppConfigId`
of the application instance.

This will activate a local SMTP daemon (currently ``postfix``) and make sure it does not
accidentally get stopped when one (but not all) other :term:`Apps <App>` using it on
this device is undeployed.
