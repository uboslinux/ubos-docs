---
layout: post
title:  "How we packaged Mattermost for UBOS"
date:   2016-07-21 15:00:00
author: Johannes Ernst
categories: howto front
---

<div style="float: right; margin: 0 0 10px 20px">
 <p><a href="https://www.mattermost.org/"><img src="/images/2016-07-21/icon.png" width="125" height="125"></a></p>
</div>

This post is a step-by-step transcript of how we packaged [Mattermost](http://mattermost.org/) for
one-command install and update on UBOS. The process turned out to be rather typical, and if you
are thinking of packaging up an app for UBOS, you can use it as a template. Reference
documentation is [here](http://localhost/docs/developers/index.html).

In case you haven't come across Mattermost, it is a very nice open-source implementation
of a group messaging platform similar to closed-source [Slack](http://slack.com/).

Installing Mattermost manually on some other Linux distro is about middle-of-the-road in terms
of difficulty. You need to have a database management system installed (MySQL or Postgres),
provision a database, upload some files, edit a configuration file, create a user and a group
for the application, change file permissions and set up a daemon configuration. If you want
to run any other app on that same server, you also need to set up a reverse proxy, which not
many people are familiar with.

On UBOS, just like with any other app that has been packaged for UBOS, our goal is to make
it as simple as:

<pre>
sudo ubos-admin createsite
</pre>

and enter `mattermost` as the name of the app. (Now of course Mattermost has been
packaged, so you can try that out right now on a UBOS device, cloud server or container
before continuing to read. [Instructions for how to set up UBOS are here](http://localhost/docs/users/index.html))

But the point of this post is to document the steps we, as UBOS developers, went through to make
it so. You can see the finished work [on Github](https://github.com/uboslinux/ubos-mattermost).

So this is what we did:

<h2>Step 1: Read through (some of) the Mattermost documentation</h2>

To understand how to run Mattermost, we first read some of the Mattermost documentation.
We are looking for system requirements in terms of libraries and dependencies on other packages
(like databases, middleware etc.). We also look for any recommendations how the app likes
to be installed in terms of directory layout, webserver configuration etc. We find:

 * Mattermost is a daemon that talks HTTP on port 8065. Because we don't want to expose
   strange port numbers to UBOS users, this means we either have to tell Mattermost to run on
   port 80 instead and thereby disallow other apps to run on the same machine (not something UBOS
   users would like), or we have to configure the UBOS web server as a reverse proxy
   (which we will do).
 * It can use either Postgresql or MySQL. UBOS supports both, so we don't care which. We
   decide to use MySQL because it is slightly more likely to already run on an UBOS device.
 * It wants to have its own Linux user and group.
 * By default, it wants to reside in `/opt/mattermost`. On UBOS, we don't use `/opt`
   and in any case, we like to keep all valuable data on `/var`, so we will need to
   override this.
 * Fortunately, Mattermost is nice and allows us to override everything through its
   configuration file. The default location of the configuration file is on `/opt`, too,
   but it turns out that the daemon can be started with an option that specifies an alternate
   location. This alternate invocation will go into the `systemd.service` file that will
   start the Mattermost daemon.
 * Nothing seems to stand in the way of running multiple Mattermost instances on the same
   machine, for different virtual hostnames. (This is advantageous of you want to host
   apps for third parties.) As a result, we take the approach to make this possible by
   default.
 * They have instructions for starting the Mattermost daemon at startup through
   `/etc/init.d`. UBOS uses systemd, so we will have to write the `systemd.service` file
   ourselves.

<h2>Step 2: Create the basic UBOS package structure</h2>

Armed with this information, we grab an Arch Linux development machine that has the
[UBOS tools installed](/docs/developers/setting-up-development-machine.html)
(in our case, its runs on a Mac using VirtualBox), and start creating a UBOS package in a
directory called `mattermost`. You can see the end result
[on Github](https://github.com/uboslinux/ubos-mattermost/tree/master/mattermost)).

We need a `PKGBUILD` file that knows how to put the `mattermost` package together. We
copy and paste an existing one (from the
[ownCloud UBOS package](https://github.com/uboslinux/ubos-owncloud) and adapt it: different
name, author, license, version, download location etc.). For now, we comment out the
subroutines that actually put the package together, and just test that the package build
will download Mattermost:

<pre>
% makepkg -f
</pre>

The download works, but then we get a checksum error. Yes, of course, the Mattermost checksum
is going to be different than the ownCloud one, and we haven't updated that. So we do:

<pre>
% makepkg -f -g
</pre>

to get the correct checksum computed, which we copy-paste into the `PKGBUILD`.

According to UBOS conventions, the Mattermost package's code should end up on the
target device in `/usr/share/mattermost`. We also see that the download has unpacked
the Mattermost files in `./src/mattermost`. So we add the following lines to the
`package()` method:

<pre>
# Code
mkdir -p ${pkgdir}/usr/share/${pkgname}/mattermost
cp -r -p ${srcdir}/mattermost/* ${pkgdir}/usr/share/${pkgname}/mattermost/
</pre>

The variables in this statement come from `makepkg`, the Arch Linux tool we use to
create the package. They are documented on the
[Arch wiki here](https://wiki.archlinux.org/index.php/Creating_packages).

Now we do:

<pre>% makepkg -f</pre>

again, and we see that a sizable file has been created:
`mattermost-1.4.0-4-x86_64.pkg.tar.xz` with about 17MB. Looking inside:

<pre>% tar tfJ mattermost-1.4.0-4-x86_64.pkg.tar.xz | more</pre>

shows us that the files are in the place we wanted them. It seems we have the rudiments of a
UBOS package for Mattermost.

<h2>Step 3: Define what should happen when the user decides to deploy Mattermost</h2>

If the user were to install the package we have created so far with something like:

<pre>% sudo pacman -U mattermost-1.4.0-4-x86_64.pkg.tar.xz</pre>

all they would get is a big dump of code into their `/usr/share/mattermost`
directory. But to run the application, we need to have a database provisioned, the
daemon started, Apache reconfigured and restarted etc. So we are not done.

First, we create a Mattermost `systemd.service` file. As we'd like to be able to run
multiple instances of Mattermost on the same machine, we create `mattermost@.service`,
with the plan to instantiate it as `mattermost@<appconfigid>.service`, as we know that
`appconfigid`s on UBOS are guaranteed to uniquely identify an app installation. Here's the file:

<pre>
[Unit]
Description=Mattermost

[Service]
WorkingDirectory=/usr/share/mattermost/mattermost
ExecStart=/usr/share/mattermost/mattermost/bin/platform -config=/etc/mattermost/%I.json
User=mattermost
Group=mattermost

[Install]
WantedBy=multi-user.target
</pre>

The daemon, as the Mattermost documentation shows, takes an argument `-config=<name>`
to specify a non-default config file. As each instance of Mattermost on a given
device needs to have its own configuration, we decide to put the instance-specific
configuration files in `/etc/mattermost/<appconfigid>.json`. (On UBOS, we generally put
configuration files in `/etc/<package>`.)

How does this instance-specific configuration file get there before the daemon gets started
when the user deploys the app? Time to create the `ubos-manifest.json`. We do this again by
copying and pasting from another existing app. In this case, we use the `gladiwashere-java`
toy app ([here in Github](https://github.com/uboslinux/ubos-toyapps/tree/master/gladiwashere-java))
because it has the dependencies for an instance-specific reverse proxy setup in it,
and we need that, too.

Getting slightly distracted, because we work down the pasted `ubos-manifest.json`, we
ponder the default relative pathname for the app. We found nothing in the Mattermost
documentation that implied we could run it at any place other than the root of the site,
and also the app is a daemon, so we decide it's unlikely it will work anywhere but the
root of the app. So we give it a `"fixedcontext" : ""` instead of a `"defaultcontext"`.
We also try to figure out package dependencies for Mattermost from the documentation,
and we find none! (Other than the database.) This sounds strange, but we'll go with it;
we'll find out later for sure. We keep the Apache modules required for the reverse proxy
setup in the manifest file, except that we need `proxy_http`, not `proxy_ajp`: the Mattermost
daemon speaks HTTP, not AJP as Tomcat does in `gladiwashere-java`.

Back to the instance-specific setup. Mattermost needs a MySQL database with all privileges
(it seems, they aren't quite clear about it). We will give it the symbolic name `maindb`,
as we usually do for databases. (UBOS will provision a unique database name upon deployment.)
We change that at the end of the `ubos-manifest.json` file. But then, we also need:

 * an Apache configuration fragment that performs the reverse proxy setup. We simply copy
   this from the `gladiwashere-java` app's `tmpl` directory, but change the port to
   Mattermost's 8065, and the protocol to `http` from `afp`.

   (Note: because we use that single, hard-coded port, we will not be able to run multiple
   instances of Mattermost on the same machine yet after all. We will be able to once
   [this extension request](https://github.com/uboslinux/ubos-admin/issues/159) has
   been implemented on UBOS.)

 * a directory for the data of the Mattermost instance. We will use
   `/var/lib/mattermost/${appconfig.appconfigid}/data`
   (parameterized with the already-mentioned `appconfigid`) as that's the recommended location
   for valuable data on UBOS. We could have put it directly into
   `/var/lib/mattermost/${appconfig.appconfigid}`, but experience shows that sometimes there
   is some other instance-specific data that also needs to be stored, so a subdirectory does not
   hurt. This subdirectory gets a `retentionpolicy` so that UBOS knows it needs to back it up
   and restore from backup when needed. This directory needs to be writable by the Mattermost
   user.

 * Detour: we need a `mattermost` user and group. So we add a file `mattermost.install` to
   our package directory, which runs a few commands to detect whether the user and group
   exist already, and if not, creates them. This gets added to the `PKGBUILD` as
   `install=mattermost.install`. This uses the same user and group for all instances of
   Mattermost on the same machine, which may be fine. This script is the usual way Arch
   Linux deals with application-specific users, and there's no need to deviate in UBOS.

 * Now, the instance-specific configuration file. We'll derive that from a template,
   which we decide to put into our package at `tmpl/config.ini.tmpl`. Where do we get the
   template from? Easy, we use the default Mattermost configuration file, and
   parameterize it. Reviewing the file, it seems that most of the default settings will
   work for us out of the box, but we need to change the data directory to the place
   in `/var/lib/...` that we picked above, and of course we need to change the
   database connection string. There are a few crypto secrets in that file that should
   also be changed, but we skip this for now just to get something to work, because so
   far we haven't proven we can run Mattermost on UBOS at all, which is more important.

 * And then, of course, we need to run an instance-specific daemon. So we just state, in
   the manifest file, that the `systemd.service` `mattermost@${appconfig.appconfigid}.service`
   needs to be run. Of course, UBOS will replace `${appconfig.appconfigid}` with a
   unique identifier at time of deployment.

Finally, we make sure that all the template files we just created get packaged into
the package, by adding them to the `package()` method in the `PKGBUILD`.

Rebuild the package:

<pre>% makepkg -f</pre>

Time to try it out.

<h2>Step 4: Debugging</h2>

Now we need to run UBOS and see what happens if we actually attempt to deploy Mattermost
on UBOS. For development purposes, it's easiest to run UBOS in a Linux container with
an ephemeral virtual file system, so that every time we restart the container, it looks
like we got a brand-new copy of UBOS. Instructions are
[here](/docs/users/installation/x86_container.html). For now, we assume
the tar file has been unpackaged in `~/ubos`.

So far, the only place where the `mattermost` package exists is on our development machine.
If we simply tried to install `mattermost`, UBOS in the container would not be able to
find it. A simple way to solve this problem is to mount the development directory in which
we put the package together into the container. So we run `systemd-nspawn` with an
extra argument:

<pre>% sudo systemd-nspawn --boot --network-veth --ephemeral \
--machine ubos --directory ~/ubos --bind $(pwd):/mattermost
</pre>

Once we log into that container from its console, we execute:

<pre>% ls -al /mattermost</pre>

and it will show the current directory of the outside host, i.e. the directory that contains
our just-built `mattermost` package.

In the container, let's install the package. To be able to do that we first need to
loosen UBOS' paranoid default security, as we haven't signed our package. Edit `/etc/pacman.conf`
so the respective line reads like:

<pre>LocalFileSigLevel = Never</pre>

We now successfully install and check that it looks right:

<pre>% sudo pacman -U /mattermost/mattermost-*.xz
% ls -al /usr/share/mattermost
% ls -al /etc/mattermost
% ls -al /var/lib/mattermost</pre>

Now we create a test [Site JSON](/docs/developers/site-json.html) that
describes the virtual host etc. we'll be using for testing that Mattermost installs
correctly:

<pre>% sudo ubos-admin createsite -n --out test-mattermost.json</pre>

specifying `ubos` as the name of the site (this should be the same as the name of
the container we used earlier, so we don't have to setup DNS as systemd will do it for us
if we have `mymachines` added to `/etc/nsswitch.conf` on the host), `mattermost` as the
name of the app, and sensible other defaults.

Now comes the hour of truth, and we run it double-verbose, so we can see what is going on:

<pre>% sudo ubos-admin deploy -f test-mattermost.json -v -v</pre>

This spits out a lot of progress messages. We worry about anything labeled
WARNING, ERROR or FATAL. INFO and DEBUG are fine. And, it turns out, there have been
no errors! (Ok, we cheated. There were various syntax errors in various places on the
first iteration, but there's no point in documenting in this blog post how we fixed
silly syntax errors.)

Now, we can point a web browser at it on our Arch host by visiting `http://ubos/`,
assuming the setup and naming above. And voila, we get the Mattermost front page!

<h2>Step 5: Making changes</h2>

Let's assume it didn't work the first time around, and we need to make changes to the
package. The easiest is to make the change, run `makepkg -f` again on the host, and
then in the container, say:

<pre>% sudo ubos-admin update --pkgfile /mattermost/mattermost-*.xz</pre>

This will perform a system upgrade of the container, except that -- because we added the
`pkgfile` flag -- UBOS pretends that only the `mattermost` package has a new version. (Even
if the version identifier has not changed.) Note that for this to work, the package can't be
completely broken, as they sometimes are in the development process. Alternatively, we can
undeploy and redeploy our test site:

<pre>% sudo ubos-admin undeploy -s s...
% sudo ubos-admin deploy -f test-mattermost.json</pre>

or, if our container got completely borked, simply shut down and restart the container and
then deploying the Site JSON again. Because of the `--ephemeral` option to `systemd-nspawn`
systemd will automatically delete the working copy of the container's file system.

<h2>Step 6: Some other things to test</h2>

Most importantly, backup and restore. With a running Mattermost instance that has some data
in it, do this:

<pre>% sudo ubos-admin backup -s s... -o testing1.ubos-backup
% sudo ubos-admin undeploy -s s...</pre>

Make sure that the instance is gone, e.g. by visiting its web page. Then, restore the backup:

<pre>% sudo ubos-admin restore --in testing1.ubos-backup</pre>

and Mattermost should be back at the same URL holding the restored data.

<h2>Step 7: Test script for the install</h2>

And finally, we should create a test script that allows us to easily test we haven't
broken anything next time UBOS, or Mattermost, gets updated. For that, in UBOS, we have
`webapptest` (see [documentation](/docs/developers/app-test.html)).

For now, we are just going to test that Mattermost comes up correctly after install, so
we create a file called `MattermostTest1.pm` in subdirectory `tests` (it could have been
anywhere). This is a Perl fragment that specifies the configuration to be set up by the
test (e.g. which app to run), and some `curl` invocations against it. Once we have it,
we can run it as:

<pre>% webapptest run MattermostTest1.pm</pre>

usually with various options, such as whether to test in a container, on a physical machine
somewhere on the network, on VirtualBox, and which test strategy to use. E.g. to test it
using the UBOS container we used above, with verbose output, and stopping after each step,
we say:

<pre>% webapptest run --scaffold container:directory=$HOME/ubos MattermostTest1.pm -i -v</pre>

<h2>The end</h2>

UBOS recommends that all apps provide icons that can be shown to the user. So we add
the recommended `72x72.png` and `144x144.png` files to subdirectory `appicons` and into
the `PKGBUILD` file so they get added to the package.

What's left is to add the new app into the official UBOS build. This means we add the
package to the build configuration [here](https://github.com/uboslinux/ubos-buildconfig),
and, voila, Mattermost is now part of UBOS. Which is what it has been since
[UBOS beta 7](/blog/2016/07/07/ubos-beta7-available.html).
