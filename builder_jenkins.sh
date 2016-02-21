#!/bin/bash
# JENKINS BUILD FILE

# DEFAULT REQ:
# 1) AMD64 JENKINS SLAVE
# 2) INSTALLED KPARTX, ZIP, WGET, 
# 2) INJECTED "HYPRIOT_RPI_VERSION" ENV (e.g. "20151115-132854")
# 3) INJECTED "STORE_DIR" ENV (e.g. /var/www/)

echo "1. DOWNLOAD IMAGE"
wget http://downloads.hypriot.com/hypriot-rpi-${HYPRIOT_RPI_VERSION}.img.zip
unzip hypriot-rpi-${HYPRIOT_RPI_VERSION}.img.zip
rm hypriot-rpi-${HYPRIOT_RPI_VERSION}.img.zip

echo "2. SETUP VIRTUAL DISK"
kpartx -a -v hypriot-rpi-${HYPRIOT_RPI_VERSION}.img

echo "3. MOUNT IMAGE"
mkdir -p /mnt/hypriot-root /mnt/hypriot-boot
mount /dev/mapper/loop0p1 /mnt/hypriot-boot
mount /dev/mapper/loop0p2 /mnt/hypriot-root
sleep 5

echo "4. RUN BUILDER SCRIPT"
./builder.sh /mnt/hypriot-boot /mnt/hypriot-root

# UPGRADE DOCKER 

# REQ (IF NEEDED):
# 1) INSTALLED DOCKER AND QEMU-ARM-STATIC
# 2) INJECTED "DOCKER_UPGRADE=YES" ENV
# 3) INJECTED "DOCKER_UPGRADE_TO_VERSION" ENV (e.g. "1.10.1-1")

if [ "${DOCKER_UPGRADE}" = "YES" ]
then
  echo "4.1 DOCKER UPGRADE"
  wget http://downloads.hypriot.com/docker-hypriot_${DOCKER_UPGRADE_TO_VERSION}_armhf.deb
  docker run -it --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static -v /mnt/hypriot-root:/mnt/hypriot-root -v $PWD:/tmp/deb datarhei/jenkins-qemu-armhf:latest dpkg --root=/mnt/hypriot-root -i /tmp/deb/docker-hypriot_${DOCKER_UPGRADE_TO_VERSION}_armhf.deb
  rm docker-hypriot_${DOCKER_UPGRADE_TO_VERSION}_armhf.deb
fi

echo "5. UNMOUNT IMAGE AND CLEANUP"
umount /mnt/hypriot-root
umount /mnt/hypriot-boot
kpartx -d -v hypriot-rpi-${HYPRIOT_RPI_VERSION}.img
sleep 5
rm /mnt/hypriot-root /mnt/hypriot-boot -R

echo "6. CREATE NEW IMAGE FILE"
DATE=$(date '+%Y%m%d')
mv hypriot-rpi-${HYPRIOT_RPI_VERSION}.img restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img
zip restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img.zip restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img
rm restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img
shasum -a 256 restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img.zip >> $STORE_DIR/SHASUM256.txt

echo "7. PUBLISH IMAGE"
mv restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img.zip $STORE_DIR/restreamer-hypriot-rpi-$DATE-$BUILD_NUMBER.img.zip
