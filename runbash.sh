#!/bin/bash
IMGVERSION=$(head -n 1 .IMGVERSION)
IMG_VERSION=${IMG_VERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
ARGPROXY=
[[ ! -z "$http_proxy" ]] && ARGPROXY="-e 'http_proxy=$http_proxy'"
[[ ! -z "$https_proxy" ]] && ARGPROXY="$ARGPROXY -e 'https_proxy=$https_proxy'"
[[ ! -z "$no_proxy" ]] && ARGPROXY="$ARGPROXY -e 'no_proxy=$no_proxy'"
docker run --rm -ti $ARGPROXY \
  $IMGNAME:$IMGVERSION bash

