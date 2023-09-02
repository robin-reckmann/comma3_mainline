#!/bin/bash
scp linux/linux-*.deb tici:/tmp/
ssh comma@tici "sudo apt install -yq /tmp/linux*.deb"
