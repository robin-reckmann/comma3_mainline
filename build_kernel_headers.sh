#!/usr/bin/env sh

(cd linux && make bindeb-pkg O=out ARCH=arm64 CROSS_COMPILE="ccache aarch64-linux-gnu-" -j $(nproc))
