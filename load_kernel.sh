#!/bin/bash -e
cd "$(dirname "$0")"
scp out/boot.img tici:/tmp/
ssh tici "sudo dd if=/tmp/boot.img of=/dev/disk/by-partlabel/boot_a && sudo reboot"

