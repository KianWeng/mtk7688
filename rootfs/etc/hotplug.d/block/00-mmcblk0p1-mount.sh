#!/bin/sh

MMC_PARTITION_NAME=mmcblk0p1

if [ "${DEVICENAME}" = "${MMC_PARTITION_NAME}" -a "${ACTION}" = "add" ]; then
	mount -o noatime /dev/${DEVICENAME} /media/sd/
	[ -d /media/sd/CASS ] || {
		mkdir -p /media/sd/CASS/ALARM /media/sd/CASS/BACKUP /media/sd/CASS/STATE /media/sd/CASS/UPDATE
		mkdir -p /media/sd/CASS/FTP/CAMERA /media/sd/CASS/FTP/INFO /media/sd/CASS/FTP/PIC
		chown -R nobody /media/sd/CASS
	}
elif [ "${DEVICENAME}" = "${MMC_PARTITION_NAME}" -a "${ACTION}" = "remove" ]; then
	umount /media/sd/
else
	echo > /dev/null
fi

