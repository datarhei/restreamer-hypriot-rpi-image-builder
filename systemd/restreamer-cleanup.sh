#!/bin/bash
# Datarhei/Restreamer cleanup script
RESTREAMER_RUNNING=$(docker ps --filter "name=restreamer" | wc -l)
if  [ "$RESTREAMER_RUNNING" = "2" ]
then
  docker kill restreamer
fi
RESTREAMER_KILLED=$(docker ps -a --filter "name=restreamer" | wc -l)
if  [ "$RESTREAMER_KILLED" = "2" ]
then
  docker rm restreamer
fi