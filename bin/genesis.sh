#!/bin/bash
GEN_NONCE="0xeddeadbabeeddead"
GEN_CHAIN_ID=1981
sed "s/\${GEN_NONCE}/$GEN_NONCE/g" config/genesis.json.template | sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" > config/genesis.json
