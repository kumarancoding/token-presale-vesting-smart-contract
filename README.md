# ERC20 Token + Whitelist Presale (Hardhat, Sepolia)

A smart contract project built with **Solidity + Hardhat** for deploying an **ERC20 token** and an **improved whitelist-based token presale** on the **Sepolia testnet**.

This project includes:

* **LaunchToken** — ERC20 token contract
* **TokenPresale** — improved whitelist presale contract
* deployment and test scripts
* Sepolia deployment proof

---

## Features

### LaunchToken

* ERC20 token using OpenZeppelin
* token name: **Launch Token**
* token symbol: **LTT**
* initial supply minted to deployer
* owner-only mint function
* burn function for token holders

### Improved TokenPresale

* whitelist-based token sale
* configurable token price
* min / max buy per transaction
* max total buy limit per wallet
* ETH spent tracking per user
* purchased token tracking per user
* total tokens sold tracking
* sale token cap
* pause / resume sale
* withdraw raised ETH
* withdraw unsold tokens
* event emissions for important actions

---

## Tech Stack

* **Solidity** `^0.8.20`
* **Hardhat**
* **OpenZeppelin Contracts**
* **Ethers.js**
* **Sepolia Testnet**

---

## Project Structure

```bash
token-presale/
├─ contracts/
│  ├─ LaunchToken.sol
│  ├─ TokenPresale.sol
│  └─ TokenPresale_V1.sol
│
├─ scripts/
│  ├─ deploy.js
│  ├─ deploy-presale.js
│  ├─ fund-presale.js
│  ├─ whitelist.js
│  ├─ buy-test.js
│  └─ check-presale-status.js
│
├─ .env
├─ hardhat.config.js
├─ package.json
└─ README.md
```

---

## Contracts

### 1) LaunchToken

ERC20 token contract used for the presale.

#### Main functions

* `mint(address to, uint256 amount)` — owner-only mint
* `burn(uint256 amount)` — burn caller’s tokens

---

### 2) TokenPresale

Improved whitelist token presale contract.

#### Main functionality

* add / remove whitelist users
* buy tokens with ETH
* enforce per-transaction min / max limits
* enforce total wallet purchase limit
* track user ETH spent
* track user token purchases
* track total tokens sold
* cap the total tokens sold in the presale
* withdraw ETH and unsold tokens

---

## Sepolia Deployment

### LaunchToken

`0xDEc095338bf60406A63B6948c64b063D68c50799`

### Improved TokenPresale

`0x335B7362282eC6ec1bDd80D60c3eAD084d788946`

### Sale Token Cap

`500000 LTT`

---

## Example Presale Parameters

* **Token price:** `0.001 ETH` per token
* **Min buy:** `0.01 ETH`
* **Max buy per transaction:** `1 ETH`
* **Max total buy per wallet:** `2 ETH`

---

## Setup

### 1) Clone the repository

```bash
git clone <your-repo-url>
cd token-presale
```

### 2) Install dependencies

```bash
npm install
```

### 3) Create `.env`

Add your wallet private key and RPC URL:

```env
PRIVATE_KEY=your_private_key_here
SEPOLIA_RPC_URL=your_rpc_url_here
```

> Never commit your real private key or `.env` file to GitHub.

---

## Compile

```bash
npx hardhat compile
```

---

## Deploy LaunchToken

```bash
npx hardhat run scripts/deploy.js --network sepolia
```

---

## Deploy Improved TokenPresale

```bash
npx hardhat run scripts/deploy-presale.js --network sepolia
```

---

## Fund the Presale

```bash
npx hardhat run scripts/fund-presale.js --network sepolia
```

This transfers presale tokens from the deployer wallet to the presale contract.

---

## Whitelist a Buyer

```bash
npx hardhat run scripts/whitelist.js --network sepolia
```

---

## Test Buy from Presale

```bash
npx hardhat run scripts/buy-test.js --network sepolia
```

---

## Check Presale Status

```bash
npx hardhat run scripts/check-presale-status.js --network sepolia
```

This script checks:

* buyer token balance
* presale token balance
* ETH raised
* user ETH spent
* user tokens purchased
* total tokens sold
* remaining tokens for sale

---

## Example Working Flow

1. Deploy `LaunchToken`
2. Deploy `TokenPresale`
3. Fund the presale with tokens
4. Whitelist a wallet
5. Buy tokens using Sepolia ETH
6. Verify balances and sale status

---

## Notes

* This project is currently deployed and tested on **Sepolia testnet**
* It is intended as a reusable **token presale smart contract package**
* The code can be extended further with:

  * vesting / claim contracts
  * frontend dashboard
  * multi-stage sale logic
  * stablecoin payments

---

## License

MIT License

---

## Author

Built as a Solidity / Hardhat token presale project for learning, deployment practice, and reusable smart-contract product development.
