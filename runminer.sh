#!/bin/sh
NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"miner1"}
./runnode.sh $NODE_NAME --mine --minerthreads=1 --etherbase=0x0000000000000000000000000000000000000001
