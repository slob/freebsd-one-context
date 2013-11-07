## OpenNebula one-context port for FreeBSD

This is a Port of the one-context package which allows contextualisation of
FreeBSD VMs created using OpenNebula.

It's a port in the FreeBSD tradition so you can build a package from it
and install it on a FreeBSD system to take care of configuring the
OpenNebula-provided IP, netmask, nameservers etc.

I won't claim it's particularly well written but it seems to work for
me. Here are a the gotchas I can think of:

 * multiple NICs might not work - I assume, probably incorrectly for
   some configurations, that ifconfig will return NICs in the same
   order OpenNebula defines them. This may not be true.

 * Auto-mounting swap required some diddling with opennebula scripts
   (diff at the end) to make the swap device discernable to FreeBSD.
   There might be a better way to do it.

And finally, I only tested this on OpenNebula 4.2 (on debian) running
a minimal FreeBSD 9.2 image.

```
+++ /usr/lib/one/sh/scripts_common.sh	2013-11-07 01:42:21.876367331 +0000
@@ -42,6 +42,7 @@
 RM=rm
 SCP=scp
 SED=sed
+SGDISK=sgdisk
 SSH=ssh
 SUDO=sudo
 SYNC=sync
@@ -277,6 +278,13 @@
             echo "$MKSWAP -L swap $DST"
             return 0
             ;;
+        "freebsd-swap")
+            echo "$SGDISK --clear $DST"
+            echo "$SGDISK --new=1:2048: $DST"
+            echo "$SGDISK --typecode=1:a502 $DST"
+            echo "$SGDISK --change-name=1:gpswap $DST"
+            return 0
+            ;;
         "qcow2")
             echo "$QEMU_IMG create -f qcow2 $DST ${SIZE}M"
             return 0
```
