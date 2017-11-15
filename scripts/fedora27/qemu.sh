#!/bin/bash

error() {
        if [ $? -ne 0 ]; then
                printf "\n\nqemu addons failed to install...\n\n";
                exit 1
        fi
}


# Bail if we are not running atop QEMU.
if [[ `dmidecode -s system-product-name` != "KVM" && `dmidecode -s system-manufacturer` != "QEMU" ]]; then
    exit 0
fi

# Install the QEMU using Yum.
printf "Installing the QEMU Tools.\n"

dnf --assumeyes install acpid qemu-guest-agent; error
systemctl enable acpid.service && systemctl start acpid.service; error
systemctl enable qemu-guest-agent.service; error