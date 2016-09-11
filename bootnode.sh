#!/bin/sh
#
# Executa bootnode
#
# Se houver NET_ID repassa para o container como --environment
# Senão vale o default do Dockerfile:
# NET_ID=1972
#
docker stop ethereum-bootnode
docker rm ethereum-bootnode
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
    bacen/ethereum --verbosity=3
