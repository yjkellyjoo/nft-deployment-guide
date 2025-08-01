# NFT Deployment Guide

## NFT Contract code walkthrough

### Ownable

## Multi-sig Wallet Creation

## Deployment

#### Step 1: Prepare Your Contract
1. Compile your contract:
   ```bash
   forge build
   ```

2. Get the ABI json of the contract. The json file should be under `out/NFT.sol/DomoNFT.json`.

#### Step 2: Set up Environment
Create a `.env` file in the foundry directory:
```bash
PRIVATE_KEY=your_private_key_here
ETHERSCAN_API_KEY=get-your-etherscan-api-key-from-https://etherscan.io/apidashboard
```

#### Step 3: Deploy to Ethereum Sepolia
```bash
# Load environment variables
source .env

# Deploy to local network for testing
forge script script/DeployNFT.s.sol --rpc-url http://localhost:8545 --broadcast

# Deploy to testnet
forge script script/DeployNFT.s.sol --rpc-url eth_sepolia --broadcast --private-key $PRIVATE_KEY
```

#### Step 3: Transfer Ownership
After deployment, call the `transferOwnership` function of the contract to transfer its ownership to your Gnosis Safe wallet:
```bash
# Replace CONTRACT_ADDRESS with your deployed contract address, which can be found in the logs after deployment or under `broadcast/DeployNFT.s.sol/11155111/run-latest.json` 
# REplace GNOSIS_SAFE_ADDRESS with your Gnosis Safe smart account address
cast send CONTRACT_ADDRESS "transferOwnership(address)" GNOSIS_SAFE_ADDRESS --rpc-url eth_sepolia --private-key $PRIVATE_KEY
```
