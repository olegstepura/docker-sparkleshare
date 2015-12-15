#!/bin/bash

DIR=$(dirname $(realpath $0))
. $DIR/docker-shell/shared-functions.sh

DAZZLE_TARGET="$DIR/image-files/usr/bin/dazzle"
curl https://raw.githubusercontent.com/hbons/Dazzle/master/dazzle.sh --output "$DAZZLE_TARGET"
chmod +x "$DAZZLE_TARGET"

VAR=IMAGE POSSIBLE_NAME="sparkleshare" docker_enter_image_name

docker_build
