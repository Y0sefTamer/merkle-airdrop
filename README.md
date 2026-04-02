# 🌳 Merkle Airdrop & Signatures

This repository contains an advanced smart contract implementation of a gas-efficient token airdrop system using **Merkle Trees** and **Cryptographic Signatures**. 

It was built as part of the **Cyfrin Updraft Advanced Foundry Course**, focusing on secure, scalable, and cost-effective methods for distributing tokens to users.

## 📖 Overview

In traditional airdrops, storing a massive list of eligible addresses and their corresponding amounts directly on-chain is incredibly gas-expensive. This project solves that problem by:

1. **Merkle Trees:** Computing a Merkle Root off-chain from a list of eligible users. Only the Merkle Root is stored on-chain. Users provide a Merkle Proof to verify their eligibility, drastically reducing storage costs.
2. **Cryptographic Signatures (EIP-712):** Adding an extra layer of security. Users can securely sign a message off-chain, and a relayer can submit the transaction on their behalf to claim the airdrop (gasless claims) or to verify authorization before minting/transferring tokens.

## ✨ Features

- **Gas-Optimized Claims:** O(log N) verification complexity using Merkle Proofs.
- **EIP-712 Integration:** Typed structured data hashing and signing for secure authorization.
- **Robust Testing:** Comprehensive test suite written in Solidity using the Foundry framework.

## 🛠️ Tech Stack

- **Solidity:** Smart contract development.
- **Foundry:** Compilation, testing, and deployment framework.

## 🚀 Getting Started

### Prerequisites

You need to have [Foundry](https://getfoundry.sh/) installed on your machine.

### Installation

1. Clone the repository:
   ```bash
   git clone [https://github.com/Y0sefTamer/merkle-airdrop.git](https://github.com/Y0sefTamer/merkle-airdrop.git)
   cd merkle-airdrop
   ```
2. Install dependencies:
   ```bash
   forge install
   ```
2. Build the contracts:
   ```bash
   forge build
   ```
### Running Tests

#### To execute the test suite and verify the Merkle Proof and Signature logic:

   ```bash
   forge test
   ```

## 🧠 What I Learned

Throughout this project, I deepened my understanding of:

Building and verifying Merkle Trees off-chain and on-chain.

Understanding how ecrecover works and the intricacies of Ethereum signatures.

Implementing EIP-712 standard for structured data hashing and signing.

Advanced testing methodologies using Foundry.

