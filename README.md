Ethereum playground
==========

This works is based on the official "ethereum/go-client" docker image, without modifications. A few scripts in this project simplify playing with this image.

## Quick start

Assuming you have Docker up and running:

* Run a bootnode
* Run a common node
* Run a miner node
* Check a node's peers

```sh
./bootnode.sh
./runnode.sh
./runminer.sh
./showpeers.sh
```

## Network definition

To isolate your private Ethereum network from the main public one it does not require an isolated physical network at all. Its nodes can still reside on the Internet and yet implement a closed private Ethereum network.

This 'genesis.sh' allows the user to define environment variables that will reflect on a particular (and predictable) genesis block, therefore creating an Ethereum network that cannot interact with another one. This is done when the script generates a 'genesis.json' file that is mounted on each node's container.

Those variables are:

* GEN_NONCE: any value your nodes agree upon, the default is "0xeddeadbabeeddead"
* GEN_CHAIN_ID: any integer value your nodes agree upon, the default is 1981
* GEN_ALLOC: pre-funded accounts

The 'runnode.sh' scripts checks if the node database has already been initilized and runs 'geth init genesis.json' when needed. Similarly, the GEN_CHAIN_ID variable defines the "network_id" of the network. All members of the private network will use the same genesis file.

## Bootnode

A bootnode is a "dumb" node in the network that aids other nodes on P2P discovery.

There are several valid strategies to enable node discovery (including a static topology with disabled discovery). Having one or more bootnodes seems to be the best one, for it creates no obstacles for a dynamic network.

As a dumb node, the bootnode is a cheap and effective solution to aid the network self-discovery. It fits container-land perfectly, because any swarm can ressurect such a node almost instantly. The main Ethereum network itself is served by a set of bootnodes whose addresses are hard-coded in the "geth" client code.

The `bootnode.sh` script runs a specialized bootnode container named "ethereum-bootnode". You can check its dynamically generated URL checking its log:

```sh
docker logs ethereum-bootnode
...
INFO [12-05|02:30:08] UDP listener up      self=enode://c409a84245a91384a6743e800c4f45df31915d9c6a30c1352a4442d18e443b184107696231d714f3c3015f13263a416ec019d637fb567aea5455114f1cf161d2@[::]:30301
```

There is another useful script that parses the "enode" URL from this very same log (it is used in other scripts to find the bootnode URL automatically):

```sh
./getbootnodeurl.sh
enode://76e50d0dd4ae583d2653d414f9acd1df4e7a75f4bab53c7cafedc6433696ba9596c6dc84626423e629760b3ab2af9f97220dfee73961cb5be1a8ce1fa40a0bff@172.17.0.4:30301
```

## Volumes

The provided utility scripts are meant for local development use and rely on local volumes to persist data. For example, the script `runnode.sh <node_name>` creates a local volume ".ether-<node_name>" at the current folder. When using this container in production you should try another strategy to guarantee the node portability.

The folders created bu each script are:

* bootnode.sh: volume ".bootnode"
* runnode.sh: volume ".ether-<node_name>" (ex: "./runnode node1" creates the volume ".ether-node1")
* runminer.sh: volume ".ether-<miner_name>" (id.)

Note: if ran without arguments the scripts `runnode.sh` and `runminer.sh` assume the argument "node1" and "miner1", respectively.

## Your first node

The script `runnode.sh` runs the first node in your private Ethereum network (a container named "ethereum-node1"). It is important to notice that it looks for and connects to the bootnode, but since it is alone in the world it won't find any peer (yet) - the bootnode is a dumb node that doesn't count as a peer. 

```sh
./runnode.sh
```

## Your second node

The same script `runnode.sh` can be used to run as many other nodes you want, all you need is to supply a node name as its argument. A container named "ethereum-<node_name>" will be created and started, looking for the bootnode and eventually finding the first node (and the others you ran) as its peer.

```sh
./runnode.sh node2
```

## Checking the nodes' peers

Self-discovery can take a few seconds, but it is easy to check it with the script `showpeers.sh`. The command below shows the peers of container "ethereum-node":

```sh
./showpeers.sh
```

An optional argument can specify another node container to be checked: 

```sh
./showpeers.sh node2
```

## Running a miner node

The nodes "ethereum-node1" e "ethereum-node2" are non-mining nodes - they served the purpose of testeing the ability to create a private Ethereum network capable of self-discovery. Another script `runminer.sh` is similar to the `runnode.sh`, but it starts mining nodes (it assumes "miner1" if ran without arguments):

```sh
./runminer.sh [node_name]
```

To check if it discovered its peers "node1" and "node2":

```sh
./showpeers.sh ethereum-miner1
```

Mining can take quite a long time to run for the first time. Onde again, to check the node work and status you can always go for the container log:

```sh
docker logs -f ethereum-miner1
```

# My notes

Create two accounts

```
make start
make console

adam = personal.newAccount("pwd")
eve = personal.newAccount("pwd")
```

Get adam's id and put it in genesis json alloc.  Then transfer funds

```
make stop
make start
make console

adam = eth.accounts[0]
eve = eth.accounts[1]

personal.unlockAccount(adam,'pwd',0)
personal.unlockAccount(eve,'pwd',0)

eth.sendTransaction({from: adam, to: eve, value: web3.toWei(4, "ether")})

web3.fromWei(eth.getBalance(adam), "ether");
web3.fromWei(eth.getBalance(eve), "ether");
```

