#!/usr/bin/env sh

BOOT_IMG_FOLDER=out
BOOT_IMG=$BOOT_IMG_FOLDER/boot.img

cat ./linux/out/arch/arm64/boot/Image.gz ./linux/out/arch/arm64/boot/dts/qcom/sdm845-comma3.dtb > $BOOT_IMG_FOLDER/Image.gz-dtb

# Make boot image
mkbootimg \
  --kernel $BOOT_IMG_FOLDER/Image.gz-dtb \
  --ramdisk /dev/null \
  --pagesize 4096 \
  --base 0x80000000 \
  --kernel_offset 0x8000 \
  --ramdisk_offset 0x8000 \
  --tags_offset 0x100 \
  --output $BOOT_IMG.nonsecure

# le signing
openssl dgst -sha256 -binary $BOOT_IMG.nonsecure > $BOOT_IMG.sha256
openssl pkeyutl -sign -in $BOOT_IMG.sha256 -inkey vble-qti.key -out $BOOT_IMG.sig -pkeyopt digest:sha256 -pkeyopt rsa_padding_mode:pkcs1
dd if=/dev/zero of=$BOOT_IMG.sig.padded bs=2048 count=1
dd if=$BOOT_IMG.sig of=$BOOT_IMG.sig.padded conv=notrunc
cat $BOOT_IMG.nonsecure $BOOT_IMG.sig.padded > $BOOT_IMG
