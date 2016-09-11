#!/bin/sh
docker stop $(docker ps -q -f name=ethereum)
docker rm $(docker ps -aq -f name=ethereum)
rm -Rf .ether-*/.et*
rm -Rf .bootnode/*
