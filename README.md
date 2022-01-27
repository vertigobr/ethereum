Ethereum Private Network
==========

Scripts to use the official "ethereum/go-client" docker image.

## Quick start

Assuming you have Docker up and running, lets init the `config/genesis.json` file

```
make init
```

Start everything with `make start` and stop it with `make stop`.  Clean out all data and start over with `make clean`.


## Network definition

To isolate your private Ethereum network from the main public one it does not require an isolated physical network at all. Its nodes can still reside on the Internet and yet implement a closed private Ethereum network.

This 'genesis.sh' allows the user to define environment variables that will reflect on a particular (and predictable) genesis block, therefore creating an Ethereum network that cannot interact with another one. This is done when the script generates a 'genesis.json' file that is mounted on each node's container.

Those variables are:

* GEN_NONCE: any value your nodes agree upon, the default is "0xeddeadbabeeddead"
* GEN_CHAIN_ID: any integer value your nodes agree upon, the default is 1981
* GEN_ALLOC: pre-funded accounts

## Containers

A bootnode is a "dumb" node in the network that aids other nodes on P2P discovery and does not count as a peer.

The nodes are peers and maintain the blockchain

The miner works the blockchain and gets paid for it.

## Volumes

The provided utility scripts are meant for local development use and rely on local volumes to persist data. For example, the script `runnode.sh <node_name>` creates a local volume ".ether-<node_name>" at the current folder. When using this container in production you should try another strategy to guarantee the node portability.

The folders art

* .bootnode
* .ether-<node_name>
* .ether-<miner_name>

# Console

Create new accounts

```
adam = personal.newAccount("pwd")
eve = personal.newAccount("pwd")
```

Get adam's id and put it in genesis json alloc.  Then transfer funds

```
adam = eth.accounts[0]
eve = eth.accounts[1]

personal.unlockAccount(adam,'pwd',0)
personal.unlockAccount(eve,'pwd',0)

eth.sendTransaction({from: adam, to: eve, value: web3.toWei(4, "ether")})

web3.fromWei(eth.getBalance(adam), "ether");
web3.fromWei(eth.getBalance(eve), "ether");
```

check adams account

```
adam = eth.accounts[0]
web3.fromWei(eth.getBalance(adam), "ether");
```