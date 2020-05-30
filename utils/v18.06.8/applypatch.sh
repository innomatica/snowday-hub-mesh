#!/bin/bash

# experimental version of mbedtls
use_mbedtls_exp=0

if [ $use_mbedtls_exp -eq 1 ]; then
	# delete directories under package
	rm -rf ../../openwrt18/package/libs/mbedtls/
	rm -rf ../../openwrt18/package/libs/ustream-ssl/
	# delete files under dl
	rm -f ../../openwrt18/dl/mbedtls-*
	rm -f ../../openwrt18/dl/ustream-ssl-*
	# delete directories under build_dir
	rm -rf ../../openwrt18/build-dir/target-mipsel_24kc_musl/mbedtls-*
	rm -rf ../../openwrt18/build-dir/target-mipsel_24kc_musl/ustream-ssl-mbedtls
	# copy patch contents
	cp -a patch/package/libs/mbedtls ../../openwrt18/package/libs/
	cp -a patch/package/libs/ustream-ssl ../../openwrt18/package/libs/
fi

# update i2c kernel driver patches
cp patch/target/linux/ramips/patches-4.14/* ../../openwrt18/target/linux/ramips/patches-4.14/

# apply patch for onion omega device
cd ../../openwrt18
git apply ../utils/v18.06.8/patch/omega.patch

# boost Makefile patch: do this after feeds install
git apply ../utils/v18.06.8/patch/boost.patch
