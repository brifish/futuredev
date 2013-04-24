#!/bin/bash -e
# hooks are always called with two arguments

op=$1       # backup / restore
state=$2    # pre / post

if [ "$op" == "restore" ] && [ "$state" == "post" ]; then

    sed -i "/multiverse/ s/# //g" /etc/apt/sources.list.d/*.list

    export DEBIAN_FRONTEND=noninteractive
    
    apt-get update

    apt-get -y install PACKAGE1 PACKAGE2

fi
