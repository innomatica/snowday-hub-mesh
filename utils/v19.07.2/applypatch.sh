#!/bin/bash

# update i2c kernel driver patches
cp patch/target/linux/ramips/patches-4.14/* ../../openwrt19/target/linux/ramips/patches-4.14/
# apply mtd m25p80 kernel driver patch
cp patch/target/linux/generic/pending-4.14/* ../../openwrt19/target/linux/generic/pending-4.14/


# This should go to the feed or something: DO NOT APPLY THIS MORE THAN ONCE

# experimental version of mbedtls
use_mbedtls_exp=0
# patch for onion omega devices
onion_omega_patch=0

if [ $use_mbedtls_exp -eq 1 ]; then
	# delete directories under package
	rm -rf ../../openwrt19/package/libs/mbedtls/
	rm -rf ../../openwrt19/package/libs/ustream-ssl/
	# delete files under dl
	rm -f ../../openwrt19/dl/mbedtls-*
	rm -f ../../openwrt19/dl/ustream-ssl-*
	# delete directories under build_dir
	rm -rf ../../openwrt19/build-dir/target-mipsel_24kc_musl/mbedtls-*
	rm -rf ../../openwrt19/build-dir/target-mipsel_24kc_musl/ustream-ssl-mbedtls
	# copy patch contents
	cp -a patch/package/libs/mbedtls ../../openwrt19/package/libs/
	cp -a patch/package/libs/ustream-ssl ../../openwrt19/package/libs/
fi

if [ $onion_omega_patch -eq 1 ]; then
	cd ../../openwrt19
	git apply ../utils/v19.07.2/patch/omega.patch
fi
