---
layout: post
title:  Change of license for ubos-admin
date:   2018-03-02 15:00:00
author: Johannes Ernst
categories: front legal
---

TL;DR:
------

We are changing the license for some code written specifically for UBOS. If
you are an individual, nothing changes for you.

Background:
----------

UBOS, like all Linux distributions, consists of code that was written by many developers
in many projects, and that is licensed by those developers under a wide variety of different
licenses. These include the General Public License, the Apache License, the Perl Artistic
License, the BSD License, and many others, sometimes in different editions and versions.
Other copyrightable items in Linux distributions, such as artwork or fonts, are often
licensed under Creative Commons licenses.

We have been pondering for a long time what the appropriate license is for functionality
that we built specifically for UBOS. Much of this unique functionality is contained in a handful
of UBOS packages such as ``ubos-admin``, which so far have been licensed using the GNU Public
License or the Affero GNU Public License. Which seemed fine, as it encourages the hacker
spirit of "feel free to take it apart, examine it, improve it, make it work for you,
as long as you share alike" that we very much support.

But there another value we'd like to promote, and that is to see more successful technology
products in the market that do not spy on their users, that can be opened and repaired by
their users, that aren't tied into somebody else's, unaccountable cloud, nor are part of some
big internet company's take-over-the-world strategy, with users being mere sharecroppers.
That was the whole inspiration for UBOS in the first place!

So the challenge is: how do we enable hackers to hack whatever they please and enable
respectful product developers to use the cool stuff we built in their products, while
keeping the would-be overlords from using technology we created for one thing to
accomplish the opposite? (And not spend thousands of dollars on lawyers to come up with
big scary new license that would scare off everybody and perhaps not even stand up in
court: it's hard to define what a would-be overlord company is in a license agreement...)

We discussed this challenge with a variety of developers and users of free and open-source
software, starting with attendees at OSBridge back in Portland, OR, last year. Based on
their input and feedback, here's what we came up with. Starting with the next UBOS release,
we are changing the license of some of the UBOS packages accordingly:

* We take the <a href="https://www.gnu.org/licenses/gpl-3.0.en.html">General Public License
  Version 3 (GPL)</a>

* ... and we modify a single sentence. We search for the string that says:

  <blockquote>"Licensees" and "recipients" may be individuals or organizations.</blockquote>

  and replace it with:

  <blockquote>"Licensees" and "recipients" may only be individuals. Organizations may not
  be licensees using this license.</blockquote>

* Assuming nobody objects to the name, we are going to call this the **Personal** Public License
  Version 3, because it's "personal" only now, and not "general" (short: PPL3)

So what will this do?

1. If you are an individual, you have all the same rights and obligations as if you
   had obtained the code under GPL: you can run it, hack it, distribute it, combine it
   etc. like anything else using GPL.

2. If you are working for a company and you wish to use the code for the business
   of that company: this license does not permit you to do that.

3. But if you are working for a company that supports values compatible with what we just
   outlined, get in touch. Notice that our modification to GPL is not intended
   to be non-commercial! We definitely want to see more cool new products and features
   in the market that don't screw the user, and are open to work with you to find a
   license that meets the needs of your products and its users. If we indeed have
   compatible values, that should be very doable and we might want to partner anyway.

4. You might have noticed that this model also creates the opportunity for a business model
   that is not otherwise available to open-source software. For us and our partners, it
   effectively prevents some big company to stomp on the business of a little company by simply
   forking their code and rebranding it. (Now where have we heard of this before?)

Obviously, none of the code that we didn't write ourselves (i.e. 99%+ of what's in UBOS)
remains licensed the way it always has by the developers of that code.

We realize, of course, that other approaches to solving our conundrum are possible,
but we'd like to try this one. What do you think?
