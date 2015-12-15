#!/bin/bash

DIR=$(dirname $(realpath $0))
. $DIR/docker-shell/shared-functions.sh

VAR=CONTAINER_NAME docker_select_container

sudo docker exec -ti "$CONTAINER_NAME" dazzle $*
