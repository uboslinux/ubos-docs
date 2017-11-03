MySQL Replication Setup (advanced)
==================================

Some of you crazy ones might want to use UBOS to run web applications with a replicated
MySQL database. For example, you might want to run the same web app on three UBOS instances,
with each of those instances having a separate MySQL database. To keep the data in sync,
we can use MySQL master-master replication.

Master-slave configurations can be set up in a similar fashion.

UBOS and master-master replication
----------------------------------

Here's the core problem. If you install your app on host 1 (using ``ubos-admin createsite``,
for example), UBOS will install the web application and provision the database on that
host 1. If you have set up master-master replication with a second host 2 already, it
will take that the database content of host 2 is already the same. If you now install the
same site on host 2, UBOS will be confused because the database is there already.

If you make the two installs before you configure master-master replication, you avoid that
problem but it re-appears when you attempt to do updates:
subsequent updates will fail.
