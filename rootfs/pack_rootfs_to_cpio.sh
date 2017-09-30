#!/bin/bash -

find . \( -name '.svn' -o -name pack_rootfs_to_cpio.sh -o -name Makefile \) -prune -o -print | \
	cpio -o -H newc | gzip > ../rootfs.cpio.gz
