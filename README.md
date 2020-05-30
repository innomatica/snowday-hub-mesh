* [Building Firmware](#building-firmware)
 * [Preparing Source](#preparing-source)
 * [Applying Patches](#applying-patches)
 * [Firmware Configuration](#firmware-configuration)
 * [Choosing Mesh Role](#choosing-mesh-role)
 * [Compilation](#compilation)
* [About Mesh Configuration](#about-mesh-configuration)
* [References](#references)


# Building Firmware

## Preparing Source

Run the script

```
./pull_openwrt19.sh
```
This will pull down OpenWrt source from the repo and checkout the version
v19.07.2.  Then

```
cd openwrt19

./scripts/feeds update -a
./scripts/feeds install -a
```
to install feeds.

## Applying Patches

Vanila OpenWrt source needs some patches for ssues about the I2C driver and
the M25P mtd driver.

```
cd utils/v19.07.2
./applypatch.sh
```

## Choosing Mesh Role

You need to choose the role of the device in the mesh network.
Check [this for more information](#about-mesh-configuration)

```
cd utils/v19.07.2
./precompile.sh
```

## Compilation

```
cd openwrt19
make menuconfig
```

Select/deselect items on the menu to suit your purpose.
For the mesh operation, all you need is	`wpad-mesh-openssl`.
However you may have to remove other conflicting `wpad` packages.

After the menuconfig, run
```
make -jN
```
N could be any number depending on your processor.

Following settings are for the reference purpose only.

### Target Settings

* Target System > MediaTek Ralink MIPS
* Subtarget > MT76x8 based board
* Target Profile > Onion Omega2+

### Global setting

* Global build settings > Compile with support for patented functionality

### 802.11s mesh

* Network > wpad-mesh-openssl

### I2C Support (needs patch)

* Kernel Modules > I2C support > kmod-i2c-core
* Kernel Modules > I2C support > kmod-i2c-mt7628

### Devmem

* Global build settings > Kernel build options > /dev/men virtual drive support
* Base system > busybox > Miscellaneous Utilities > devmem

### USB MSD Support

* Base System > block-mount
* Kernel Modules > Filesystem > kmod-fs-exfat
* Kernel Modules > Filesystem > kmod-fs-vfat
* Kernel Modules > USB Support > kmod-usb-storage

### Lua

* Language > Lua > lua
* Language > Lua > lsqlite3
* Language > Lua > lua-cjson
* Language > Lua > luabitop

### uhttpd

* Network > Web Servers / Proxies > uhttpd
* Network > Web Servers / Proxies > uhttpd-mod-lua
* Network > Web Servers / Proxies > uhttpd-mod-ubus

### Relay

* Network > Routing and Redirection > relayd


### BATMAN-adv (does not work as of this writing)

* Kernel modules > Network support > kmod-batman-adv
* Network > batctl

### Libraries

* Libraries > libcurl

### Utilities

* Base system > busybox > Editors > diff
* Base system > busybox > Editors > Support undo command "u"
* Base system > busybox > Editors > Enable undo operation queuing


# About Mesh Configuration

Current implementation is based on 802.11s mesh, which is known to be stable for
long time. B.A.T.M.A.N. is also known to be using 802.11s for Layer 2 protocol.
However it does not seem to be working on Omega 2 (MT7688AN).

## Mesh Portal and Mesh AP

A typical mesh network consists of one mesh portal and many mesh APs.
The mesh portal in this project is set to connect to WAN via Ethernet,
while mesh APs are connects to client devices vi WiFi.
802.11s relays packets to and from each device at Layer 2 level. And
TCP/IP protocol works on top of it without issues.


## Configuration

Configuration of UCI for mesh roles can be selected during firmware compilation.
Check /utils/vxx.xx.x/precompilation.sh for `mesh_role` setting.
Both mesh portal and mesh ap are identical in mesh settings, but differ only in
the lan settings.


# References

* [802.11s based wireless mesh network](https://openwrt.org/docs/guide-user/network/wifi/mesh/80211s)
* [B.A.T.M.A.N/batman-adv](https://openwrt.org/docs/guide-user/network/wifi/mesh/batman)

