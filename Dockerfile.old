# Ethereum playground for private networks
#
FROM ethereum/go-ethereum:v1.7.2

LABEL maintainer="andre@vertigo.com.br"

ENV GEN_NONCE="0xeddeadbabeeddead" \
    DATA_DIR="/root/.ethereum" \
    CHAIN_TYPE="private" \
    RUN_BOOTNODE=false \
    GEN_CHAIN_ID=1981 \
    BOOTNODE_URL=""

WORKDIR /opt

# inherited from ethereum/client-go
# EXPOSE 30303
# EXPOSE 8545

# bootnode port
EXPOSE 30301
EXPOSE 30301/udp

ADD src/* /opt/
RUN chmod +x /opt/*.sh

ENTRYPOINT ["/opt/startgeth.sh"]

