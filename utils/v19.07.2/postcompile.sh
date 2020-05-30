rm -rf firmware/*

cp -a ../../openwrt19/bin/targets/ramips/mt76x8/* firmware/
cp -a ../../openwrt19/bin/packages/mipsel_24kc/base firmware/
cp -a ../../openwrt19/bin/packages/mipsel_24kc/routing firmware/
