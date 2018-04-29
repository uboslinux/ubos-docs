---
layout: post
title:  "Migrating sites running on UBOS to Letsencrypt"
date:   2016-08-25 15:00:00
author: Johannes Ernst
categories: front howto
---

If you have a site that currently doesn't use SSL/TLS encryption, or you use a
a certificate from a different provider, UBOS lets you easily move to a Letsencrypt
certificate.

<a href="https://letsencrypt.org/"><img src="/images/2016-08-25/letsencrypt-logo-horizontal.svg" alt="[Letsencrypt logo]" style="float: right; margin-left: 20px"></a>

[Letsencrypt.org](https://letsencrypt.org/) is a wonderful idea. If it didn't exist,
somebody would have to invent it! Of course, there are many certificate authorities
from where you can obtain SSL/TLS certificates for your website, so the traffic
to and from your website is encrypted and cannot be read or altered by anybody.

But Letsencrypt is different in some important ways:

* Letsencrypt certificates are free! While over the years, certificates from other providers
  have come down in price, there are still certificate authorities out there even today
  that charge hundreds of dollars per year, for a dubious value proposition.

* Installation of certificates from Letsencrypt can be much simpler than the installation
  of certificates from other places. Still, it is not for the faint of heart, unless
  you are running UBOS, in which case you basically have to do nothing other than saying
  `--tls --letsencrypt` on the command-line when creating a new site with
  `ubos-admin createsite`.

* There's an automatic renewal process for expiring certificates.

But what if you already run a site on UBOS and would like to secure it with Letsencrypt?
It's quite easy:

Let's say your site's hostname is `example.com`. First, obtain its Site JSON and save it
into a convenient place, like this:

<pre>% sudo ubos-admin showsite --json --host example.com > example.com.json</pre>

Then, edit it to say "get and use a letsencrypt certificate". You do that by opening
up the newly saved `example.com.json` file in a text editor of your choice. Then, you
look for the "tls" section. If you already used SSL/TLS, there will be such a section
with all your certificate information in it. Delete the lines in the "tls" section, and
specify to use letsencrypt instead, by making it look like this:

<pre>   "tls" : {
      "letsencrypt" : true
   }</pre>

If you hadn't used SSL/TLS for your site yet, simply add the above section at the end of the
file, before the closing `}`. Make sure that there's a comma before that added section according to
JSON syntax rules.

Then, redeploy the site:

<pre>% sudo ubos-admin deploy -f example.com.json</pre>

and voila, your new site will be protected by an automatically-provisioned SSL/TLS
certificate from Letsencrypt.

P.S. If you use Firefox, restart the browser before you check whether you indeed have the
new certificate; in our test Firefox thought it still used the old one.
