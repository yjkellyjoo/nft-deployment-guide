# NFT Deployment Guide with Multisig Integration

A complete NFT deployment workflow demonstrating secure smart contract development with multi-signature wallet integration.

## 📋 Project Overview

This project showcases a complete NFT deployment with enhanced security features:

- ✅ **Deploy an NFT on Ethereum Sepolia** and verify the contract on Etherscan
- ✅ **Restrict minting functionality to Admin address** (multisig wallet)
- ✅ **Mint an NFT through the multisig**
- ✅ **Document the process** and record a showcase video

## 🎥 Showcase Video

**Watch the complete walkthrough:** [NFT Deployment Guide Video](https://youtu.be/SQ8c4LUbt5Q?si=t6HQWUALbUdNCBcB)

The video covers the entire process from contract deployment to multisig minting, including:
- Contract deployment to Sepolia testnet
- Contract verification on Etherscan
- Multisig wallet setup and ownership transfer
- NFT minting through the multisig wallet

## 🚀 Deployed Contract

**Contract Address:** `0x9e449e4f3b0b97464d4830471d65c9c9919b8502`  
**Network:** Ethereum Sepolia  
**Explorer:** [View on Sepolia Etherscan](https://sepolia.etherscan.io/address/0x9e449e4f3b0b97464d4830471d65c9c9919b8502)

## 📖 Detailed Guide

For a comprehensive walkthrough of the entire process, see the complete guide in [`GUIDE.md`](foundry/GUIDE.md).

## 🛠️ Technical Stack

- **Smart Contract Framework:** Foundry
- **Network:** Ethereum Sepolia Testnet
- **Multisig Solution:** Gnosis Safe
- **Contract Standard:** OpenZeppelin ERC721 (NFT)
- **Access Control:** OpenZeppelin Ownable

## 📁 Repository Structure

```
foundry/
├── src/
│   └── NFT.sol              # Main NFT contract
├── script/
│   └── DeployNFT.s.sol      # Deployment script
├── GUIDE.md                 # Complete deployment guide
README.md                    # This file
```
