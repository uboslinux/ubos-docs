---
layout: post
title:  "Package Signature Issues"
date:   2014-09-26 15:12:11
author: Johannes Ernst
categories: ubos release
---

Update Sept 27, 2014, early morning: this issue has been resolved. The 'dev' and 'red'
channels have been updated, and new images have been created.

The 'red' channel is currently moving towards requiring package signatures from the UBOS
buildmaster before packages can be installed. There are some teething issues. If you run
into them, temporarily disable package signature checking by editing `/etc/pacman.conf`,
and changing the signature settings to optional:

~~~~~
FileSigLevel = Optional
LocalFileSigLevel = Optional
RemoteFileSigLevel = Optional
~~~~~
