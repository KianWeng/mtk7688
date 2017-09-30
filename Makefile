.PHONY:all kernel-app-libs jffspad modules_clean clean

all:YYTD-7688-squashfs-sysupgrade.bin

app_libs.squashfs:
	source/staging_dir/host/bin/mksquashfs4 rootfs_ext_partition app_libs.squashfs \
		-nopad -noappend -root-owned -comp xz -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2 -b 1024k \
		-processors 1 -fixed-time 1498014980

rootfs.cpio.gz:
	make -C rootfs

kernel-app-libs:
	dd if=source/bin/targets/ramips/mt7688/lede-ramips-mt7688-omega2p-initramfs-kernel.bin\
		of=YYTD-7688-squashfs-sysupgrade.bin
	dd if=app_libs.squashfs >> YYTD-7688-squashfs-sysupgrade.bin

jffspad:
	source/staging_dir/host/bin/padjffs2 YYTD-7688-squashfs-sysupgrade.bin 4 8 16 64 128 256

YYTD-7688-squashfs-sysupgrade.bin:rootfs.cpio.gz
	make -C source
	make app_libs.squashfs
	make kernel-app-libs
	make jffspad

clean:
	make -C uboot clean
	make -C rootfs clean
	make -C source clean
	rm -f app_libs.squashfs YYTD-7688-squashfs-sysupgrade.bin

