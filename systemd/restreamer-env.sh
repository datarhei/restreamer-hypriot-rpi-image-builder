#!/bin/bash
# Datarhei/Restreamer env builder

# restreamer docker env.
ARCH=$(arch)
RS_HTTP_PORT=$(grep "restreamer_http_port=" /boot/restreamer.txt | cut -d '=' -f2)
RS_DOCKER_IMAGE=$(grep "restreamer_docker_image=" /boot/restreamer.txt | cut -d '=' -f2)
RS_DOCKER_IMAGE_TAG=$(grep "restreamer_docker_image_tag=" /boot/restreamer.txt | cut -d '=' -f2)

# restreamer env.
RS_USERNAME=$(grep "restreamer_username=" /boot/restreamer.txt | cut -d '=' -f2)
RS_PASSWORD=$(grep "restreamer_password=" /boot/restreamer.txt | cut -d '=' -f2)
RS_LOGGER_LEVEL=$(grep "restreamer_logger_level=" /boot/restreamer.txt | cut -d '=' -f2)
RS_SNAPSHOT_REFRESH_INTERVAL=$(grep "restreamer_snapshot_refresh_interval=" /boot/restreamer.txt | cut -d '=' -f2)
RS_RASPICAM=$(grep "restreamer_raspicam=" /boot/restreamer.txt | cut -d '=' -f2)
RS_RASPICAM_WIDTH=$(grep "restreamer_raspicam_width=" /boot/restreamer.txt | cut -d '=' -f2)
RS_RASPICAM_HEIGHT=$(grep "restreamer_raspicam_height=" /boot/restreamer.txt | cut -d '=' -f2)
RS_RASPICAM_FPS=$(grep "restreamer_raspicam_fps=" /boot/restreamer.txt | cut -d '=' -f2)
RS_RASPICAM_BITRATE=$(grep "restreamer_raspicam_bitrate=" /boot/restreamer.txt | cut -d '=' -f2)

if [ "$RS_RASPICAM" = "enabled" ]
then
  MODE=RASPICAM
else
  MODE=DEFAULT
fi

# restreamer docker env.
echo ARCH=$ARCH > /etc/restreamer.service.env
echo RS_HTTP_PORT=$RS_HTTP_PORT >> /etc/restreamer.service.env
echo RS_DOCKER_IMAGE=$RS_DOCKER_IMAGE >> /etc/restreamer.service.env
echo RS_DOCKER_IMAGE_TAG=$RS_DOCKER_IMAGE_TAG >> /etc/restreamer.service.env

# restreamer env.
echo RS_MODE=$RS_MODE > /etc/restreamer.env
echo RS_USERNAME=$RS_USERNAME >> /etc/restreamer.env
echo RS_PASSWORD=$RS_PASSWORD >> /etc/restreamer.env
echo RS_SNAPSHOT_REFRESH_INTERVAL=$RS_SNAPSHOT_REFRESH_INTERVAL >> /etc/restreamer.env
echo RS_RASPICAM_WIDTH=$RS_RASPICAM_WIDTH >> /etc/restreamer.env
echo RS_RASPICAM_HEIGHT=$RS_RASPICAM_HEIGHT >> /etc/restreamer.env
echo RS_RASPICAM_FPS=$RS_RASPICAM_FPS >> /etc/restreamer.env
echo RS_RASPICAM_BITRATE=$RS_RASPICAM_BITRATE >> /etc/restreamer.env
