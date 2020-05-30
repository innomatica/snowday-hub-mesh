# Introduction

HomeKit ADK v4 requires mbedTLS v2.18.1 with crypto features.
Replacing existing mbedTLS (v2.16 in OpenWrt19 or v2.12 in Onion) requires
hosting the source code somewhere in the cloud for several reasons:

* Pulling source from GitHub repository directory (not from the release directory)
changes the file name in such way that OpenWrt build system fails to recognize.
* The crypto feature is included as a submodule, which OpenWrt build does not
support.


# Prepare Source Tree

1. Pull the source from the repo by running:
```
git clone --recursive --depth 1 --branch mbedtls-2.18.1 https://github.com/ARMmbed/mbedtls.git
```

2. Delete unnecessary folders
```
rm -rf mbedtls/.git
rm -rf mbedtls/.github
```

2. Rename the folder
```
mv mbedtls mbedtls-2.18.1
```

3. Apply paches. [See below.](#fix-mbedtls-2.18.1-for-adk-4.0)

4. Create an archive file from the source
```
tar -czvf mbedtls-2.18.1.tar.gz mbedtls-2.18.1
```

5. Compute SHA256 Hash
```
sha256sum mbedtls-2.18.1.tar.gz > sha256hash
```

6. Upload the file on the SourceForge
```
https://www.sourceforge.net/projects/mbedtls-for-adk/files
```

If you want to have different locations, you need to change the corresponding
lines in the following file
```
utils/openwrt19/patch/package/libs/mbedtls/Makefile
```

7. Open the file below and correct the hash value (PKG_HASH)
```
utils/openwrt19/patch/libs/mbedtls/Makefile
```
Then apply the patch. Alternatively you can directly change the
source file.
```
OpenWrt/package/libs/mbedtls/Makefile
```
In this case you may have to delete corresponding files under `openwrt/dl` directory
and `openwrt/build_dir` directory


# Fix mbedtls-2.18.1 for ADK 4.0

By default, OpenWrt does not activate all the features of mbedtls.
This is done by commenting out lines in the file:
```
include/mbedtls/config.h
```
of the mbedtls source.
Information about the patch can be found in the OpenWrt package build script
```
openwrt/packages/libs/mbedtls/patch/200-config.patch
```

However, you should not apply this patch directly since not only the version of
mbedtls source used here (v2.18.1) is different from the version that the
OpenWrt patch file is targetting (v2.16) but also you have to tweak the patch
itself. Otherwise OpenWrt won't compile with v2.18 of mbedtls.

Basically, you apply all the patches except one:
```
-#define MBEDTLS_HKDF_C
+//#define MBEDTLS_HKDF_C
```
This is not used by OpenWrt but required by ADK 4.0.

Thus you comment out followng define statement from the source
```
#define MBEDTLS_CIPHER_MODE_OFB
#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
#define MBEDTLS_ECP_DP_BP256R1_ENABLED
#define MBEDTLS_ECP_DP_BP384R1_ENABLED
#define MBEDTLS_ECP_DP_BP512R1_ENABLED
#define MBEDTLS_ECP_DP_CURVE448_ENABLED
#define MBEDTLS_KEY_EXCHANGE_DHE_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDHE_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_RSA_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
#define MBEDTLS_SELF_TEST
#define MBEDTLS_SSL_RENEGOTIATION
#define MBEDTLS_SSL_SESSION_TICKETS
#define MBEDTLS_SSL_TRUNCATED_HMAC
#define MBEDTLS_VERSION_FEATURES
#define MBEDTLS_CAMELLIA_C
#define MBEDTLS_CCM_C
#define MBEDTLS_CERTS_C
#define MBEDTLS_DES_C
#define MBEDTLS_PLATFORM_C
#define MBEDTLS_RIPEMD160_C
#define MBEDTLS_SSL_TICKET_C
#define MBEDTLS_VERSION_C
#define MBEDTLS_XTEA_C
```

but enable followings:

```
#define MBEDTLS_ENTROPY_FORCE_SHA256
#define MBEDTLS_RSA_NO_CRT
```
