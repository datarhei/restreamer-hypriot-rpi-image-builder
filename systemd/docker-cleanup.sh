#!/bin/bash
# Docker Cleanup

EXITED=$(docker ps -a -q -f status=exited | wc -l)
if [ "$EXITED" -ge "1" ]
then
    docker rm -v $(docker ps -a -q -f status=exited)
fi

DANGLING=$(docker images -f "dangling=true" -q | wc -l)
if [ "$DANGLING" -ge "1" ]
then
    docker rmi $(docker images -f "dangling=true" -q)
fi