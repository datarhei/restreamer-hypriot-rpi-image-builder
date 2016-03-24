#!/bin/bash

# Exec this script after mounting a hypriot sd-card upon this system
# ./builder.sh /path/to/mounted/hypriot/boot/partition /path/to/mounted/hypriot/root/partition

# set boot-path
BOOT_PATH=$1

# set root-path
ROOT_PATH=$2

# edit hostname in "occidentalis.txt"
sed -i 's/black-pearl/restreamer/g' $BOOT_PATH/occidentalis.txt

# init parameter by "restreamer.txt"
cat config/restreamer.txt > $BOOT_PATH/restreamer.txt

# init systemd services by "firstboot.sh"
cat mods/firstboot >> $ROOT_PATH/root/firstboot.sh

# add systemd config
cp systemd/*.service $ROOT_PATH/lib/systemd/system/
cp systemd/*.timer $ROOT_PATH/lib/systemd/system/
cp systemd/*.sh $ROOT_PATH/root/
chmod +x $ROOT_PATH/root/*.sh

# limit journald
sed -i 's/#SystemMaxUse=/SystemMaxUse=50MB/g' $ROOT_PATH/etc/systemd/journald.conf
sed -i 's/#RuntimeMaxUse=/RuntimeMaxUse=50M/g' $ROOT_PATH/etc/systemd/journald.conf