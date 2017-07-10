UBoot bootloader factory configuration
======================================

If you have difficulty booting the EspressoBIN with the provided instructions, it may
be because you previously change the EspressoBIN's boot loader configuration from
the factory default. For reference, here is the EspressoBIN's factory configuration
as determined by executing

.. code-block:: none

   printenv

in uBoot of a brand-new device:

.. code-block:: none

   baudrate=115200
   bootargs=console=ttyMV0,115200 earlycon=ar3700_uart,0xd0012000 root=/dev/nfs rw ip=0.0.0.0:0.0.0.0:10.4.50.254:255.255.255.0:marvell:eth0:none nfsroot=0.0.0.0:/srv/nfs/
   bootcmd=mmc dev 0; ext4load mmc 0:1 $kernel_addr $image_name;ext4load mmc 0:1 $fdt_addr $fdt_name;setenv bootargs $console root=/dev/mmcblk0p1 rw rootwait; booti $kernel_addr - $fdt_addr
   bootdelay=3
   bootmmc=mmc dev 0; ext4load mmc 0:1 $kernel_addr $image_name;ext4load mmc 0:1 $fdt_addr $fdt_name;setenv bootargs $console root=/dev/mmcblk0p1 rw rootwait; booti $kernel_addr - $fdt_addr
   console=console=ttyMV0,115200 earlycon=ar3700_uart,0xd0012000
   eth1addr=00:00:00:00:51:82
   eth2addr=00:00:00:00:51:83
   ethact=neta0
   ethaddr=F0:AD:4E:03:6A:EA
   ethprime=egiga0
   fdt_addr=0x1000000
   fdt_high=0xffffffffffffffff
   fdt_name=boot/armada-3720-community.dtb
   fileaddr=2000000
   filesize=400000
   gatewayip=10.4.50.254
   get_images=mmc dev 0; fatload mmc 0 $kernel_addr $image_name; fatload mmc 0 $fdt_addr $fdt_name; run get_ramfs
   get_ramfs=if test "${ramfs_name}" != "-"; then setenv ramfs_addr 0x3000000; tftp $ramfs_addr $ramfs_name; else setenv ramfs_addr -;fi
   hostname=marvell
   image_name=boot/Image
   initrd_addr=0xa00000
   initrd_size=0x2000000
   ipaddr=10.4.50.4
   kernel_addr=0x2000000
   loadaddr=0x2000000
   loads_echo=0
   netdev=eth0
   netmask=255.255.255.0
   ramfs_addr=-
   ramfs_name=-
   root=root=/dev/mmcblk0p1 rw
   rootpath=/srv/nfs/
   serverip=10.4.50.5
   set_bootargs=setenv bootargs $console $root ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:none nfsroot=$serverip:$rootpath $extra_params
   stderr=serial
   stdin=serial
   stdout=serial

(Some of these values will necessarily be different on your device, e.g. the Mac
addresses.)

In an attempt to trouble-shoot, manually set the environment variables in your device's
uBoot configuration to these values as closely as possible, before attempting to boot
UBOS.

