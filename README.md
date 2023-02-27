Ethereum Private Network
==========

Scripts to use the official "ethereum/go-client" docker image.

# Get Started

### `make init`

To generate a `genesis.json` file.

### `make start_nodes`

Boots up a new block chain. Peek at the containers by running `make ps`.

```
$ make ps

CONTAINER ID   IMAGE
xxxxxxx        ethereum/client-go:v1.8.12               ethereum-node2
xxxxxxx        ethereum/client-go:v1.8.12               ethereum-node1
xxxxxxx        ethereum/client-go:alltools-v1.8.12      ethereum-bootnode
```

### `make attach_node1`

To create initial accounts

```
adam = personal.newAccount("pwd")
"0x0000000000000000000000000000000000000001"

eve = personal.newAccount("pwd")
"0x0000000000000000000000000000000000000002"
```

### Start a miner

Take the id of an account you created and use it to start your miner

```
ETHERBASE=0x0000000000000000000000000000000000000001 make start_miner
```

And that will start a container where all mined coins are credited to that account.

## Transfer funds

Wait a long while for some coin to get created then transfer funds

```
$ make attach_node1

adam = eth.accounts[0]
eve = eth.accounts[1]

personal.unlockAccount(adam,'pwd',0)
personal.unlockAccount(eve,'pwd',0)

eth.sendTransaction({from: adam, to: eve, value: web3.toWei(4, "ether")})
```

## Check balance

A miner must be running to verify the transaction and it takes a bit for the transfer to go through.

```
adam = eth.accounts[0]
web3.fromWei(eth.getBalance(adam), "ether");
```

## Other Helpful Scripts

We have scripted a number of common tasks. Run `make` to see list of commands:

```
$ make

# Help 

init                  init the genesis.json file
start_nodes           start 2 nodes
start_miner           start 1 miner
seal                  run sealer
stop                  stop everything
clean                 reset everything
		      
bash                  launch a bash with 'ethereum/client-go:alltools'
ps                    see all docker containers
		      
show_node             show node peers
show_miner            show miner peers
		      
attach_miner          attach to miner 1
attach_node1          attach to node 1
attach_node2          attach to node 2
		      
list_accounts         list all ethereum accounts
copy_keystore         copy keystore
```

## Good Reads

* https://medium.com/@kacharlabhargav21/connecting-geth-to-metamask-fc2b2c89d9f9
* https://web3js.readthedocs.io/en/v1.2.11/web3-eth.html#eth-sendtransaction
* https://geth.ethereum.org/docs/interface/managing-your-accounts


# Advanced Details

## Network definition

To isolate your private Ethereum network from the main public one it does not require an isolated physical network at all. Its nodes can still reside on the Internet and yet implement a closed private Ethereum network.

This 'genesis.sh' allows the user to define environment variables that will reflect on a particular (and predictable) genesis block, therefore creating an Ethereum network that cannot interact with another one. This is done when the script generates a 'genesis.json' file that is mounted on each node's container.

Those variables are:

* GEN_NONCE: any value your nodes agree upon, the default is "0xeddeadbabeeddead"
* GEN_CHAIN_ID: any integer value your nodes agree upon, the default is 1981

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
