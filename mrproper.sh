#!/usr/bin/env sh

(cd linux && make O=out ARCH=arm64 CROSS_COMPILE="ccache aarch64-linux-gnu-" mrproper)
