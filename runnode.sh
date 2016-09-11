#!/bin/sh
NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}
CONTAINER_NAME="ethereum-$NODE_NAME"
echo "Destruindo container antigo $CONTAINER_NAME..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
NET_ARG=
GEN_ARG=
[[ ! -z $NET_ID ]] && NET_ARG="-e NET_ID=$NET_ID"
[[ ! -z $GEN_ALLOC ]] && GEN_ARG="-e GEN_ALLOC=$GEN_ALLOC"
BOOTNODE_URL=${BOOTNODE_URL:-$(./getbootnodeurl.sh)}
echo "Executando novo container $CONTAINER_NAME..."
docker run -d --name $CONTAINER_NAME \
    -v $(pwd)/.ether-$NODE_NAME:/root \
    -e "BOOTNODE_URL=$BOOTNODE_URL" \
    $NET_ARG \
    $GEN_ARG \
    bacen/ethereum --identity $NODE_NAME --cache=512 --verbosity=5 --maxpeers=3 ${@:2}

