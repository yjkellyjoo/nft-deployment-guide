# NFT Deployment Guide

This guide covers a complete NFT deployment workflow with enhanced security through multi-signature wallet integration. The process includes:

1. **Deploying an NFT on Ethereum Sepolia** - Deploy your NFT contract to the Sepolia testnet
2. **Verifying the contract on Etherscan** - Make your contract source code publicly verifiable
3. **Restricting minting functionality to a multisig address** - Configure the contract so only a multisig wallet can mint NFTs
4. **Minting an NFT through the multisig** - Use the multisig wallet to create new NFTs securely

## NFT Contract Code Walkthrough

### 1. Inheritance Chain
- `DemoNFT` inherits from `ERC721` and `Ownable`
- `ERC721` provides all standard NFT functionality
- `Ownable` adds access control with an owner role

### 2. State Variables
- `_tokenIdCounter`: Tracks the next available token ID (starts at 0)

### 3. Constructor
- Calls `ERC721("Demo NFT", "DEMO")` to set token name and symbol
- Calls `Ownable(msg.sender)` to set the deployer as the initial owner

### 4. Minting Function
- `mint(address to)`: Creates a new NFT and assigns it to the specified address
- `onlyOwner` modifier ensures only the contract owner can mint
- Uses `_safeMint()` which includes safety checks for contract recipients

### 5. Utility Function
- `totalSupply()`: Returns the total number of tokens minted so far

### Security Features
- **Access Control**: Only the owner can mint NFTs
- **Safe Minting**: Uses `_safeMint()` to prevent minting to contracts that are incapable of handling ERC-721 tokens
- **Automatic ID Assignment**: Token IDs are automatically incremented and assigned

## NFT Contract Deployment

### Step 1: Compile your contract

```bash
forge build
```

### Step 2: Set up Environment

Create a `.env` file in the foundry directory and add your private key:

```bash
PRIVATE_KEY=your_private_key_here
```

### Step 3: Deploy to Ethereum Sepolia

```bash
# Load environment variables
source .env

# (Optional) Deploy to local network for testing
forge script script/DeployNFT.s.sol --rpc-url http://localhost:8545 --broadcast

# Deploy to testnet
forge script script/DeployNFT.s.sol --rpc-url eth_sepolia --broadcast --private-key $PRIVATE_KEY
```

## NFT Contract Verification

### Step 1: Add your Etherscan API key value in `.env` file

```bash
ETHERSCAN_API_KEY=get-your-etherscan-api-key-from-https://etherscan.io/apidashboard
```

### Step 2: Verify Contract

```bash
forge verify-contract --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url eth_sepolia CONTRACT_ADDRESS DemoNFT
```

### Step 3: Check The Verification

After verification, you can view your contract on Etherscan:

1. Go to [Sepolia Etherscan](https://sepolia.etherscan.io)
2. Search for your contract address
3. Verify that the "Contract" tab shows the verified source code

## Multi-signature Wallet

For better security, we will use a multisig wallet and make it admin of the contract. We will be using Gnosis Safe - the current market leader of multisig providers - to create the wallet.

### Multisig Wallet Creation

1. Go to [app.safe.global](https://app.safe.global)
2. Click "Create Safe"
3. Choose your network (Sepolia for this demo)
4. Add signer wallets and configure the required number of signatures. (Note that the signer wallets need to hold some Sepolia ETH or coin of your network choice to execute transactions)
5. Deploy your Safe wallet by signing with one of your signer wallets
6. Note down your Safe wallet address for later use

### Transfer Contract Ownership to Multisig Wallet

After deployment, call the `transferOwnership` function of the contract to transfer its ownership to your Safe wallet:

```bash
# Replace CONTRACT_ADDRESS with your deployed contract address. It can be found in the logs after deployment or under `broadcast/DeployNFT.s.sol/11155111/run-latest.json` 
# Replace SAFE_ADDRESS with your Safe wallet address
cast send CONTRACT_ADDRESS "transferOwnership(address)" SAFE_ADDRESS \
  --rpc-url eth_sepolia \
  --private-key $PRIVATE_KEY
```

## Minting with Multisig Wallet

### Step 1: Get your Contract ABI json

```bash
forge inspect DemoNFT abi --json >> DemoNFT.abi.json
```

### Step 2: Submit Mint Transaction via Safe Web Interface

1. Go to [app.safe.global](https://app.safe.global)
2. Connect your Safe wallet
3. Navigate to "Apps" → "Transaction Builder"
4. Upload your NFT contract ABI from Step 1
5. Select the `mint` function to call
6. Update the `to` address to give the minted NFT to
7. Submit the transaction through your multi-sig process

### Step 3: Process Multisig

The `mint` transaction submitted through Step 2 will be queued under your wallet dashboard `Transactions - Queue` section.

1. Connect to one of your signer wallets and confirm the transaction
2. Repeat the confirmation process for the number of times you have configured when creating the Safe wallet
3. Once the confirmations are done, execute the transaction (again with one of the signer wallets)

### Step 4: Verify Minting

You can verify an NFT has been minted:
- Under the `Transaction details` of Safe Wallet Dashboard or
- On [Sepolia Etherscan](https://sepolia.etherscan.io) with the confirmed transaction hash

### Important Notes

- **Multi-signature Process**: All transactions through Safe require the configured number of signatures
- **Gas Fees**: You will need to have enough funds in the Signer wallets to pay for gas fees when signing
- **Ownership**: Only the contract owner can mint (in this case it should be the Safe Smart Account wallet)
- **Token IDs**: Start from 0 and increment automatically

### Troubleshooting

#### "Transaction Failed" in Safe Interface

- Check if the Safe wallet signers have enough ETH for gas
- Verify the recipient address is valid
- Ensure the Safe wallet is the contract owner
