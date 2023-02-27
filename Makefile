.DEFAULT_GOAL := help
BLUE := $(shell tput setaf 4)
RESET := $(shell tput sgr0)
help:
	@printf "\n# Help \n\n"
	@grep -E '^[^ .]+: .*?## .*$$' $(MAKEFILE_LIST) \
		| awk '\
			BEGIN { FS = ": .*##" };\
			{ gsub(";", "\n\t\t      ") }; \
			{ printf "%-20s$(RESET) %s\n", $$1, $$2 }'
	@printf "\n"

init: ## init the genesis.json file
	@./bin/genesis.sh
	@echo "generated file config/genesis.json"

start_nodes: ## start 2 nodes
	./bootnode.sh
	RPC_PORT=8545 ./runnode.sh node1
	./runnode.sh node2

start_miner: ## start 1 miner
	./runminer.sh miner1

seal: ## run sealer
	./runsealer.sh

stop: ## stop everything
	./bin/killall.sh

clean: ## reset everything;
	./bin/wipeall.sh
	sudo rm -Rf .ether-*
	sudo rm -Rf .ethash
	sudo rm -Rf .bootnode

bash: ## launch a bash with 'ethereum/client-go:alltools'
	./bin/runbash.sh
ps: ## see all docker containers;
	docker ps

show_node: ## show node peers
	./bin/showpeers.sh node1
show_miner: ## show miner peers;
	./bin/showpeers.sh miner1

attach_miner: ## attach to miner 1
	./bin/runattach.sh ethereum-miner1
attach_node1: ## attach to node 1
	./bin/runattach.sh ethereum-node1
attach_node2: ## attach to node 2;
	./bin/runattach.sh ethereum-node2

copy_keystore: ## copy keystore
	sudo cp ./keystore/* .ether-node1/keystore
	sudo cp ./keystore/* .ether-node1/keystore
	sudo cp ./keystore/* .ether-miner1/keystore