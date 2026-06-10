# Token Presale & Vesting Smart Contracts

## Overview

This project is a Solidity smart contract system built using Hardhat and OpenZeppelin.

The project contains three smart contracts:

* LaunchToken.sol
* TokenPresale.sol
* VestingVault.sol

These contracts demonstrate token creation, token sales, and vesting functionality commonly used in Web3 projects.

## Features

### LaunchToken

An ERC-20 token built with OpenZeppelin.

Features:

* Token minting by owner
* Token burning by holders
* Ownership control
* ERC-20 standard compliance

### TokenPresale

A token sale contract that allows users to purchase tokens.

Features:

* Whitelist support
* Minimum purchase limits
* Maximum purchase limits
* Pause and resume sale
* Owner fund withdrawal

### VestingVault

A vesting contract for locking tokens until a specified release date.

Features:

* Vesting schedule creation
* Time-based token release
* Claim functionality
* Owner-controlled vesting creation

## Technology Stack

* Solidity ^0.8.20
* Hardhat
* OpenZeppelin Contracts
* Git
* GitHub

## Project Structure

contracts/
├── LaunchToken.sol
├── TokenPresale.sol
└── VestingVault.sol

## Compile

```bash
npx hardhat compile
```

## Deploy

Deployment scripts can be added to deploy the contracts to a blockchain test network.

## Purpose

This project was developed as a Web3 portfolio project to demonstrate smart contract development skills including:

* ERC-20 token development
* Token presales
* Vesting systems
* Hardhat development workflow
* Git and GitHub version control

## License

MIT
