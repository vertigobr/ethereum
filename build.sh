#!/bin/bash
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
ARGPROXY=
[[ ! -z "$http_proxy" ]] && ARGPROXY="--build-arg http_proxy=$http_proxy"
[[ ! -z "$https_proxy" ]] && ARGPROXY="$ARGPROXY --build-arg https_proxy=$https_proxy"
[[ ! -z "$no_proxy" ]] && ARGPROXY="$ARGPROXY --build-arg no_proxy=$no_proxy"
echo "Building $IMGNAME:latest"
[[ ! -z "$ARGPROXY" ]] && echo "ARGPROXY=$ARGPROXY"
docker build $ARGPROXY \
  -t "$IMGNAME:$IMGVERSION" .
echo "Done!"
