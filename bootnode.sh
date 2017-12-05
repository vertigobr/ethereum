#!/bin/sh
#
# Runs a bootnode with ethereum official "alltools" image.
#
docker stop ethereum-bootnode
docker rm ethereum-bootnode
IMGNAME="ethereum/client-go:alltools-v1.7.3"
DATA_ROOT=${DATA_ROOT:-$(pwd)}
# generate bootnode key if needed
mkdir -p $DATA_ROOT/.bootnode
if [ ! -f $DATA_ROOT/.bootnode/boot.key ]; then
    echo "$DATA_ROOT/.bootnode/boot.key not found, generating..."
    docker run --rm \
        -v $DATA_ROOT/.bootnode:/opt/bootnode \
        $IMGNAME bootnode --genkey /opt/bootnode/boot.key
    echo "...done!"
fi
[[ -z $BOOTNODE_SERVICE ]] && BOOTNODE_SERVICE="127.0.0.1"
docker run -d --name ethereum-bootnode \
    -v $DATA_ROOT/.bootnode:/opt/bootnode \
    --network ethereum \
    $IMGNAME bootnode --nodekey /opt/bootnode/boot.key "$@"
# --addr "$BOOTNODE_SERVICE:30301" "$@"


