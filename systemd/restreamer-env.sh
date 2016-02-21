#!/bin/bash

# Datarhei/Restreamer env builder

ARM_VERSION=$(uname -m | cut -c 1-6)
RESTREAMER_USERNAME=$(grep "restreamer_username=" /boot/occidentalis.txt | cut -d '=' -f2)
RESTREAMER_PASSWORD=$(grep "restreamer_password=" /boot/occidentalis.txt | cut -d '=' -f2)
RESTREAMER_HTTP_PORT=$(grep "restreamer_http_port=" /boot/occidentalis.txt | cut -d '=' -f2)
RESTREAMER_RASPICAM=$(grep "restreamer_raspicam=" /boot/occidentalis.txt | cut -d '=' -f2)
RESTREAMER_SNAPSHOT_REFRESH_INTERVAL=$(grep "restreamer_snapshot_refresh_interval=" /boot/occidentalis.txt | cut -d '=' -f2)
RESTREAMER_LOGGER_LEVEL=$(grep "restreamer_logger_level=" /boot/occidentalis.txt | cut -d '=' -f2)

if [ "$RESTREAMER_RASPICAM" = "enabled" ]
then
  RESTREAMER_MODE=RASPICAM
else
  RESTREAMER_MODE=DEFAULT
fi

echo ARM_VERSION=$ARM_VERSION > /etc/restreamer.service.env
echo RESTREAMER_HTTP_PORT=$RESTREAMER_HTTP_PORT >> /etc/restreamer.service.env

echo RESTREAMER_USERNAME=$RESTREAMER_USERNAME > /etc/restreamer.env
echo RESTREAMER_PASSWORD=$RESTREAMER_PASSWORD >> /etc/restreamer.env
echo MODE=$RESTREAMER_MODE >> /etc/restreamer.env
echo SNAPSHOT_REFRESH_INTERVAL=$RESTREAMER_SNAPSHOT_REFRESH_INTERVAL >> /etc/restreamer.env
echo LOGGER_LEVEL=$RESTREAMER_LOGGER_LEVEL >> /etc/restreamer.env