# BPM Contracts

> Solidity contracts for Bitcoin Payment Module (BPM)

## Used tools

* [Hardhat](https://hardhat.org/) - Ethereum development environment for professionals

## Quick start

> clone/fork bpm-contracts:

```bash
git clone https://github.com/zh/bpm-contracts
```

> install and start your Hardhat chain:

```bash
cd bpm-contracts
yarn install
yarn chain
```

> (optional) in a second terminal window, deploy your contract:

```bash
cd multi-evm
yarn deploy

// deploy on another blockchains
yarn deploy --network testnetSmartBCH
yarn deploy --network testnetFantom
```

> testing

```bash
yarn test
```
