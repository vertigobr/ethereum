
#https://medium.com/@kacharlabhargav21/connecting-geth-to-metamask-fc2b2c89d9f9
#https://web3js.readthedocs.io/en/v1.2.11/web3-eth.html#eth-sendtransaction
#https://geth.ethereum.org/docs/interface/managing-your-accounts

start:
	./bootnode.sh
	RPC_PORT=8545 ./runnode.sh node1
	./runnode.sh node2
	./runminer.sh miner1

stop:
	./killall.sh

clean:
	sudo rm -rf .eth*
	./wipeall.sh

console:
	./runattach.sh ethereum-miner1

peers:
	./showpeers.sh

ps:
	docker ps