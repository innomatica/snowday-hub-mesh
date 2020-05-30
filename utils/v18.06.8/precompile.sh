#!/bin/bash

# remove local root foler
rm -rf ./files/root
# create a new one
mkdir -p ./files/root

# collect files to the folder

# remove target folders
rm -rf ../../openwrt18/files/root
rm -rf ../../openwrt18/files/etc

# populate target root folder
mkdir -p ../../openwrt18/files/root
cp files/root/* ../../openwrt18/files/root

# populate target etc folder
mkdir -p ../../openwrt18/files/etc/config
mkdir -p ../../openwrt18/files/etc/uci-defaults
mkdir -p ../../openwrt18/files/etc/init.d

cp files/etc/config/mesh/* ../../openwrt18/files/etc/config/
cp files/etc/uci-defaults/* ../../openwrt18/files/etc/uci-defaults/
