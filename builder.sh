#!/bin/bash

# Exec this script after mounting a hypriot sd-card upon this system
# ./builder.sh /path/to/mounted/hypriot/boot/partition /path/to/mounted/hypriot/root/partition

# set boot-path
BOOT_PATH=$1

# set root-path
ROOT_PATH=$2

# init parameter by "occidentalis.txt"
cat mods/occidentalis >> $BOOT_PATH/occidentalis.txt

# init systemd services by "firstboot.sh"
cat mods/firstboot >> $ROOT_PATH/root/firstboot.sh

# add systemd config
cp systemd/*.service $ROOT_PATH/lib/systemd/system/
cp systemd/*.sh $ROOT_PATH/root/
chmod +x $ROOT_PATH/root/*.sh
