export STAGING_DIR = $(HOME)/Projects/sensorhub/openwrt18/staging_dir
TOOLCHAIN_DIR = $(STAGING_DIR)/toolchain-mipsel_24kc_gcc-7.3.0_musl
#PATH = $(TOOLCHAIN_DIR)/bin:$(PATH)

#export STAGING_DIR
#export PATH

export CC = $(TOOLCHAIN_DIR)/bin/mipsel-openwrt-linux-musl-gcc
export LD = $(TOOLCHAIN_DIR)/bin/mipsel-openwrt-linux-musl-ld
export AR = $(TOOLCHAIN_DIR)/bin/mipsel-openwrt-linux-musl-ar
export GDB = $(TOOLCHAIN_DIR)/bin/mipsel-openwrt-linux-musl-gdb
export RANLIB = $(TOOLCHAIN_DIR)/bin/mipsel-openwrt-linux-musl-ranlib

$(info OpenWRT CC: $(CC))
$(info OpenWRT LD: $(LD))
$(info OpenWRT AR: $(AR))
$(info OpenWRT GDB: $(GDB))
$(info OpenWRT RANLIB: $(RANLIB))

INC = -I$(STAGING_DIR)/target-mipsel_24kc_musl/usr/include
LDLIBS = -L$(STAGING_DIR)/target-mipsel_24kc_musl/usr/lib

$(info OpenWRT INC: $(INC))
$(info OpenWRT LDLIBS: $(LDLIBS))
