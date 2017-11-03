---
layout: post
title:  Cool Trick of the Day
date:   2014-09-30 15:12:11
author: Johannes Ernst
categories: howto
---

Let’s say you set up a site with some apps, but at the wrong hostname. That just happened
to me. I meant to call the hostname ‘selfoss-test’, but accidentally I called it
‘test-selfoss’.

This is what I did to correct the situation (all on one line):

~~~~~
ubos-admin showsite --host test-selfoss --json \
    | sed -e 's/test-selfoss/selfoss-test/' \
    | ubos-admin deploy --stdin
~~~~~

In English: Take the Site JSON of the site currently at hostname ‘test-selfoss’,
replace ‘test-selfoss’ with ‘selfoss-test’, and deploy. Note that because we did not
change the site id or the appconfig ids, all the data was preserved.
