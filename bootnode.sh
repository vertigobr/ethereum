#!/bin/sh
#
# Runs a bootnode
#
# If there is a NET_ID variable it is passed on to the container.
#
docker stop ethereum-bootnode
docker rm ethereum-bootnode
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
NET_ARG=
GEN_ARG=
[[ ! -z $NET_ID ]] && NET_ARG="-e NET_ID=$NET_ID"
[[ ! -z $GEN_ALLOC ]] && GEN_ARG="-e GEN_ALLOC=$GEN_ALLOC"
docker run -d --name ethereum-bootnode \
    -v $(pwd)/.bootnode:/opt/bootnode \
    -p 30301:30301 \
    -p 30301:30301/udp \
    -e "RUN_BOOTNODE=true" \
    $NET_ARG \
    $GEN_ARG \
    $IMGNAME:$IMGVERSION --verbosity=3
