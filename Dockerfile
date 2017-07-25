# Ethereum playground for private networks
#
FROM vertigo/go-ethereum:v1.6.7-all

MAINTAINER Andre Fernandes <andre@vertigo.com.br>

ENV GEN_NONCE="0xeddeadbabeeddead" \
    DATA_DIR="/root/.ethereum" \
    CHAIN_TYPE="private" \
    RUN_BOOTNODE=false \
    GEN_CHAIN_ID=1981 \
    BOOTNODE_URL=""

WORKDIR /opt

# herdados de ethereum/client-go
# EXPOSE 30303
# EXPOSE 8545

# bootnode port
EXPOSE 30301

ADD src/* /opt/
RUN chmod +x /opt/*.sh

ENTRYPOINT ["/opt/startgeth.sh"]

