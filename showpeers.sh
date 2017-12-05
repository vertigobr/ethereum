#!/bin/sh
NODE=$1
NODE=${NODE:-"node1"}
CONTAINER_NAME="ethereum-$NODE"
docker exec -ti "$CONTAINER_NAME" geth --exec 'admin.peers' attach
