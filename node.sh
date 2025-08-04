#!/bin/bash

apt-get update
apt-get install git curl tmux -y

curl -L https://foundry.paradigm.xyz | bash

export PATH="$PATH:/root/.foundry/bin"

foundryup

anvil \
  --fork-url https://sepolia.infura.io/v3/40b51d322b614ea5b09efe729586a98d \
  --fork-block-number 8439183 \
  --host 0.0.0.0 \
  --port 8545 \
  --accounts 10 \
  --balance 10000 \
  --gas-limit 30000000 \
  --gas-price 0
