# Directories

* files
 * etc/config: network setup. [check this page](https://openwrt.org/docs/guide-user/network/start)
 * etc/uci-default: check [this page](https://openwrt.org/docs/guide-developer/uci-defaults)
 * root: files in the root folder
* firmware: build output (bin folder) of the Omega firmware
* patch: patches for OpenWrt v.19

# Files

## applypatch.sh

Run this script once before initial firmware build right after the install of
the feeds. This patch deals with following issues

* Onion omega device support
* [I2C kernel driver issues](https://github.com/torvalds/linux/commit/d04913ec5f89f13760f8e8411c93cee542560d68#diff-4f54f28306d99ae2ce0aa45f235f7e14).
* mbedtls-2.18.1 patch for HomeKit compatibility


By default this patch does not include mbedtls-2.18.1 compatiblity issue.
To include this check the script.


## precompile.sh

Run this script before firmware build. This script collects files for
populating the `root` folder.

## postcompile.sh

Run this script after firmware build. This script copies the output of the
firmware build (bin folder) to `firmware` directory.  This image can be used
to update the target hardware.


## I2C kernel driver patch

Mediatek I2C kernel driver has many issues. Most notably it ignores NACK
after address was clocked in. As a result it generates error in the HomeKit app,
where the MFi chip may respond with NACK for about half second.
The file
```
0045-i2c-add-mt7621-driver.patch
```
addresses this issue.

Check [this for more information](https://github.com/torvalds/linux/commit/d04913ec5f89f13760f8e8411c93cee542560d68#diff-4f54f28306d99ae2ce0aa45f235f7e14).
Original patch was applied to the mainline kernel (v.5), this will come to
OpenWrt in the future. In such occation, this patch should be removed.


# Upgrading Root Files

If you want to upgrade root files after deploying the firmware, use this
method.
Copy target files from `files/root` folder to the target device, e.g.,
```
scp files/root/Bridge root@192.168.1.xxx:~
```
Be sure to run `dbtools.lua` on the target device if DB schema has been
changed.


# Updating Firmware

Find firmware image in the firmware directory.  Copy it onto a USB stick and
rename it as
```
omega2.bin
```

## Using Bootloader
Plug in the USB stick, press and hole the reset(prog) button, then recycle the
power of the device. You should be able to see the bootloader menu waiting
for the boot method. Select `2` on the menu.

## Using Sysupgrade
Plug in the USB stick, confirm that the system automatically mount it on
`/mnt/sda1` folder. Then run:
```
# sysupgrade /mnt/sda1/omega2.bin
```

Check [this page for more information.](https://docs.onion.io/omega2-docs/manual-firmware-installation.html)
