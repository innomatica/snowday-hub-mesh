#!/bin/bash

#mesh_role="portal"
mesh_role="ap"

# remove local root foler
rm -rf ./files/root
# create a new one
mkdir -p ./files/root

# collect files to the folder

# remove target folders
rm -rf ../../openwrt19/files/root
rm -rf ../../openwrt19/files/etc

# populate target root folder
mkdir -p ../../openwrt19/files/root
cp files/root/* ../../openwrt19/files/root

# populate target etc folder
mkdir -p ../../openwrt19/files/etc/config
mkdir -p ../../openwrt19/files/etc/uci-defaults
mkdir -p ../../openwrt19/files/etc/init.d

cp files/etc/config/* ../../openwrt19/files/etc/config/
cp files/etc/uci-defaults/* ../../openwrt19/files/etc/uci-defaults/

if [ "$mesh_role" = "portal" ]; then
	cp files/etc/uci-defaults/portal/* ../../openwrt19/files/etc/uci-defaults/
elif [ "$mesh_role" = "ap" ]; then
	cp files/etc/uci-defaults/ap/* ../../openwrt19/files/etc/uci-defaults/
fi
