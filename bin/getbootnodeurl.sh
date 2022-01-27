#!/bin/bash
# reads current bootnode URL
ENODE_LINE=$(docker logs ethereum-bootnode 2>&1 | grep enode | head -n 1)
# replaces localhost by container IP
MYIP=$(docker exec ethereum-bootnode ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')
ENODE_LINE=$(echo $ENODE_LINE | sed "s/127\.0\.0\.1/$MYIP/g" | sed "s/\[\:\:\]/$MYIP/g")
echo "enode:${ENODE_LINE#*enode:}"
