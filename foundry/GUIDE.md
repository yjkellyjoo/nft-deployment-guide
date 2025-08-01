# NFT Deployment Guide

## NFT Contract code walkthrough

### Ownable

## Multi-sig Wallet Creation

## NFT Contract Deployment

### Step 1: Compile your contract
   ```bash
   forge build
   ```

### Step 2: Set up Environment
Create a `.env` file in the foundry directory:
```bash
PRIVATE_KEY=your_private_key_here
ETHERSCAN_API_KEY=get-your-etherscan-api-key-from-https://etherscan.io/apidashboard
```

### Step 3: Deploy to Ethereum Sepolia
```bash
# Load environment variables
source .env

# Deploy to local network for testing
forge script script/DeployNFT.s.sol --rpc-url http://localhost:8545 --broadcast

# Deploy to testnet
forge script script/DeployNFT.s.sol --rpc-url eth_sepolia --broadcast --private-key $PRIVATE_KEY
```

### Step 4: Transfer Ownership
After deployment, call the `transferOwnership` function of the contract to transfer its ownership to your Gnosis Safe wallet:
```bash
# Replace CONTRACT_ADDRESS with your deployed contract address, which can be found in the logs after deployment or under `broadcast/DeployNFT.s.sol/11155111/run-latest.json` 
# Replace GNOSIS_SAFE_ADDRESS with your Gnosis Safe smart account address
cast send CONTRACT_ADDRESS "transferOwnership(address)" GNOSIS_SAFE_ADDRESS \
  --rpc-url eth_sepolia \
  --private-key $PRIVATE_KEY
```

## Minting with Multi-sig Wallet

### Step 1: Get your Contract ABI json
```bash
forge inspect DemoNFT abi --json >> DemoNFT.abi.json
```

### Step 2: Submit Mint Transaction via Gnosis Safe Web Interface

1. Go to [app.safe.global](https://app.safe.global)
2. Connect your Safe wallet
3. Navigate to "Apps" → "Transaction Builder"
4. Upload your NFT contract ABI from Step 1
5. Select the `mint` function to call
6. Update the `to` address to give the minted NFT to
7. Submit the transaction through your multi-sig process

### Step 3: Process Multi-sig 
The `mint` transaction submitted through Step 2 will be queued under your wallet dashboard `Transactions - Queue` section.

1. Connect to one of your signer wallets and confirm the transaction. 
2. Repeat the confirmation process for the number of times you have configured when creating the Gnosis Safe wallet. 
3. Once the confirmations are done, execute the transaction (again with one of the signer wallets).

### Step 4: Verify Minting
You can verify an NFT has been minted:
- Under the `Transaction details` of Safe Wallet Dashboard or
- On [Sepolia Etherscan](https://sepolia.etherscan.io) with the confirmed transaction hash. 

### Important Notes

- **Multi-signature Process**: All transactions through Gnosis Safe require the configured number of signatures.
- **Gas Fees**: You will need to have enough funds in the Signer wallets to pay for gas fees when signing. 
- **Ownership**: Only the contract owner can mint (in this case it should be the Safe Smart Account wallet).
- **Token IDs**: Start from 0 and increment automatically.

### Troubleshooting

#### "Transaction Failed" in Safe Interface
- Check if the Safe wallet signers have enough ETH for gas
- Verify the recipient address is valid
- Ensure the Safe wallet is the contract owner
