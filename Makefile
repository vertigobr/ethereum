
#https://medium.com/@kacharlabhargav21/connecting-geth-to-metamask-fc2b2c89d9f9
#https://web3js.readthedocs.io/en/v1.2.11/web3-eth.html#eth-sendtransaction
#https://geth.ethereum.org/docs/interface/managing-your-accounts
init:
	@./bin/genesis.sh
	@echo "generated file config/genesis.json"

start:
	./bootnode.sh
	RPC_PORT=8545 ./runnode.sh node1
	./runnode.sh node2
	./runminer.sh miner1

stop:
	./bin/killall.sh

clean:
	./bin/wipeall.sh
	sudo rm -Rf .ether-*
	sudo rm -Rf .ethash
	sudo rm -Rf .bootnode

attach_node:
	./bin/runattach.sh ethereum-node1

attach_miner:
	./bin/runattach.sh ethereum-miner1

bash:
	./bin/runbash.sh

node_peers:
	./bin/showpeers.sh node1

miner_peers:
	./bin/showpeers.sh miner1
ps:
	docker ps