#!/bin/sh

system_led_path=$(uci get system.system_led.sysfs)

[ "${ACTION}" = "add" -a "${INTERFACE}" = "ppp0" ] &&
echo netdev > /sys/class/leds/${system_led_path}/trigger &&
echo ppp0 > /sys/class/leds/${system_led_path}/device_name &&
echo 'link tx rx' > /sys/class/leds/${system_led_path}/mode

[ "${ACTION}" = "remove" -a "${INTERFACE}" = "ppp0" ] &&
echo heartbeat > /sys/class/leds/${system_led_path}/trigger

