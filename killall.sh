#!/bin/sh
docker stop ethereum-node
docker rm ethereum-node
docker stop ethereum-node2
docker rm ethereum-node2
docker stop ethereum-miner
docker rm ethereum-miner
docker stop ethereum-bootnode
docker rm ethereum-bootnode

