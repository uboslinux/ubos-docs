Reliably send e-mail via Amazon Web Services' Simple E-mail Service (app ``amazonses``)
=======================================================================================

Reliably sending e-mail from a device or cloud server you control, unfortunately, is
not easy. Because historically, e-mail has no concept of security, and spammers are
sending trillions of unwanted and malicious messages, most e-mail providers have
implemented strict, and always-changing heuristics that determine whether or not
an e-mail they received ever gets forwarded to the recipient's e-mail in-box. In our
experience, naively sending off e-mail via SMTP from a random cloud server results in
about 50% delivered messages, with the rest being discarded or lost on the way.

However, many apps on UBOS need to reliably send e-mail, such as for example
to confirm account sign-ups.

Enter app ``amazonses``. If you use ``ubos-admin createsite`` to setup a site called
``example.com`` which will run, say, Mediawiki, enter ``mediawiki`` as the name of the
app to run at this site, but then continue and specify ``amazonses`` as the second app
running on the same site.

``ubos-admin createsite`` will ask you for credentials (more about those below), but
once you have entered them, UBOS will send all outgoing e-mail originating from
``example.com`` via Amazon Web Services' Simple E-mail Service (SES). Amazon, not
surprisingly, works hard to be on the good side of e-mail providers world-wide, which
means that the e-mail you send via them has a high reputation, and will likely be
delivered (unless you send spam, of course).

If you run more than one site on the same device, outgoing e-mail originating from a
different domain will not be affected and will continue to be sent directly, without
going through Amazon SES. If you would like that outgoing e-mail to go through SES as
well, simply add ``amazonses`` as an additional app to that site as well.

Note that you need to have a control of the DNS settings of the domain from which you
want to send your e-mails, otherwise Amazon will not permit you to do so.

How to run ``amazonses`` as a second app if ``ubos-admin createsite`` does not ask
----------------------------------------------------------------------------------

Some apps, such as Mastodon, can only run at the root of the site. When you create
a new site with such an app, ``ubos-admin createsite`` will not ask for a second app,
because other web apps cannot run at the same site. However, ``amazonses`` is not a web
app (it has no web interface), so it can run! So how can you enter it?

Simple: always specify ``amazonses`` as the first app when running ``ubos-admin createsite``.
And then enter ``mastodon``, or whatever other app you want to run at the root of the site
as the second app.

How to sign up for Amazon Web Services' Simple E-mail Service and get credentials
---------------------------------------------------------------------------------

Here are the steps:

#. Go to `https://console.aws.amazon.com/ses <https://console.aws.amazon.com/ses>`_
   and log into your Amazon Web Services account. If you do not have an Amazon Web
   Services account, create one.

#. In the left sidebar, select "Domains"

#. Click on "Verify a New Domain" and enter the name of your DNS domain from where your
   e-mail will originate, such as ``example.com``.

#. At your domain name registrar, or DNS provider, enter the additional domain name
   records that Amazon displays. You can ignore all aspects of "receiving e-mail" as
   UBOS currently is not set up to receive and/or dispatch incoming e-mails.

#. Wait until you have received e-mail confirmation that your domain has been verified, and
   the status of your domain in the SES console has turned "verified".

#. Select "SMTP settings" in the left sidebar in the SES console.

#. Click "Create my SMTP credentials".

#. Click through the wizard, and select "Show User SMTP Security Credentials". This shows
   two values. Enter those two values when ``ubos-admin createsite`` asks for those values
   (see discussion above). "SMTP Username" is the same thing as ``aws_access_key_id`` and
   "SMTP Password" is the same as ``aws_secret_key``.

Note: It is possible that Amazon first places your account into a "sandbox", which
strongly limits which e-mail addresses you can send messages to. Usually, requesting to
be let out of the sandbox is a straightforward process. Check the SES control panel whether
you need to do that.
