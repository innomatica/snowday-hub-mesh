rm -rf firmware/*

mkdir -p firmware

cp -a ../../openwrt18/bin/targets/ramips/mt76x8/* firmware/
cp -a ../../openwrt18/bin/packages/mipsel_24kc/base firmware/
cp -a ../../openwrt18/bin/packages/mipsel_24kc/routing firmware/
