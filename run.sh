#!/bin/bash

DIR=$(dirname $(realpath $0))
. $DIR/docker-shell/shared-functions.sh

VAR=IMAGE docker_select_image
VAR=CONTAINER_NAME docker_enter_container_name
VAR=LOCALPATH DESC="storage" PLACEHOLDER="/docker/sparkleshare/home/storage/" docker_enter_dir
VAR=LOGPATH DESC="logs" PLACEHOLDER="/var/log/docker/sparkleshare/" docker_enter_dir
VAR=SSH_PORT DESC="SSH" PLACEHOLDER="22" docker_enter_port
VAR=FANOUT_PORT DESC="pubsub service (fanout)" PLACEHOLDER="1986" docker_enter_port

ARGUMENTS="--restart=always --publish $SSH_PORT:22 --publish $FANOUT_PORT:1986 --volume $LOCALPATH:/home/storage/ --volume $LOGPATH:/var/log/host/" docker_run

