#!/bin/bash
GEN_NONCE="0xeddeadbabeeddead"
GEN_CHAIN_ID=1981
GEN_ALLOC='"0x0000000000000000000000000000000000000001": {"balance": "100000"}'
sed "s/\${GEN_NONCE}/$GEN_NONCE/g" src/genesis.json.template | sed "s/\${GEN_ALLOC}/$GEN_ALLOC/g" | sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" > genesis.json
