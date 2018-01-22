systemctl reboot
systemctl halt

not reboot and shutdown






# ubos-admin update
ERROR: Command failed: pacman -S ubos-admin --noconfirm
resolving dependencies...
looking for conflicting packages...

Packages (2) java-runtime-common-3-1  ubos-admin-0.239-6

Total Download Size:   0.15 MiB
Total Installed Size:  0.74 MiB
Net Upgrade Size:      0.07 MiB

:: Proceed with installation? [Y/n]
:: Retrieving packages...
downloading java-runtime-common-3-1-any.pkg.tar.xz...
downloading ubos-admin-0.239-6-any.pkg.tar.xz...
checking keyring...
checking package integrity...
loading package files...
checking for file conflicts...
error: failed to commit transaction (conflicting files)
ubos-admin: /etc/avahi/services/http.service exists in filesystem
ubos-admin: /etc/avahi/services/https.service exists in filesystem
ubos-admin: /etc/systemd/system/avahi-daemon.service exists in filesystem
ubos-admin: /usr/lib/perl5/5.26/vendor_perl/UBOS/Commands/Listnetconfigs.pm exists in filesystem
ubos-admin: /usr/lib/perl5/5.26/vendor_perl/UBOS/Commands/Setnetconfig.pm exists in filesystem
ubos-admin: /usr/lib/perl5/5.26/vendor_perl/UBOS/HostnameCallbacks/UpdateEtcHosts.pm exists in filesystem
ubos-admin: /usr/lib/perl5/5.26/vendor_perl/UBOS/Networking/NetConfigUtils.pm exists in filesystem
ubos-admin: /usr/lib/perl5/5.26/vendor_perl/UBOS/Networking/NetConfigs/Off.pm exists in filesystem
Errors occurred, no packages were upgraded.



