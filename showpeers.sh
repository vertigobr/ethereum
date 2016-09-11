#!/bin/sh
NODE=$1
NODE=${NODE:-"ethereum-node1"}
docker exec -ti "$NODE" geth --exec 'admin.peers' attach
