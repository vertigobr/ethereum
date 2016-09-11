# Ethereum playground for private networks
#
FROM ethereum/client-go

MAINTAINER Andre Fernandes <andre@vertigo.com.br>

ENV GEN_NONCE="0x0000000000009999" \
    DATA_DIR="/root/.ethereum" \
    CHAIN_TYPE="private" \
    RUN_BOOTNODE=false \
    NET_ID=1981 \
    BOOTNODE_URL=""

RUN apt-get update -y && \
    apt-get install -y bootnode iproute2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt

# herdados de ethereum/client-go
# EXPOSE 30303
# EXPOSE 8545

# bootnode port
EXPOSE 30301

ADD src/* /opt/

ENTRYPOINT ["/opt/startgeth.sh"]

