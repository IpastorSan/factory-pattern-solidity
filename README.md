# Factory Pattern with Minimal Proxy Clones

This repository accompanies the article titled ["Factory Pattern with Minimal Proxy Clones"](), The article discusses how to efficiently create multiple copies of a smart contract with customizable parameters using Minimal Proxy Clones, a pattern designed for gas efficiency.

## Summary of the Article

### Minimal Proxy Clones

Minimal proxies, defined in [EIP1167](https://eips.ethereum.org/EIPS/eip-1167), are lightweight contracts that use `delegateCall` to forward all calls to a specified implementation contract. These proxies are immutable, meaning their implementation cannot be upgraded after deployment, making them ideal for creating gas-efficient contract clones. The primary use case for minimal proxies is in the Factory Pattern, where multiple contract instances are needed.

### Implementation Details

The article guides you through implementing a Factory contract using OpenZeppelin’s `Clones` library. The factory contract allows you to create clones of a given contract template. It also introduces concepts like deterministic contract creation with `create2` opcode, predicting future contract addresses, and managing clone initialization to avoid common pitfalls.

#### Key Components

- **Factory Contract (`Factory.sol`)**: Manages the creation of clones and provides utility functions to predict addresses and track the number of clones created.
- **Cloneable ERC20 Contract (`ClonedERC20.sol`)**: A sample contract that demonstrates how to use the `initialize()` function to set up each clone with unique parameters.

The article also covers why using upgradeable contracts for non-upgradeable proxies can be beneficial, especially when dealing with contract initialization.

## Repository Structure

- **`Factory.sol`**: The factory contract responsible for creating and managing the clones.
- **`ClonedERC20.sol`**: An example ERC20 contract that is clonable using the factory pattern.
- **`README.md`**: This document, providing an overview of the project and its purpose.

## Prerequisites

- **Solidity**: Version 0.8.26
- **OpenZeppelin Contracts**: Version 5.0.2 for the `Clones` library.
- **Foundry & Soldeer**: For dependency management and contract compilation.

## Installation

Clone the repository and install dependencies using Foundry and Soldeer:

```bash
git clone https://github.com/your-repo/factory-pattern-minimal-proxy-clones.git
cd factory-pattern-minimal-proxy-clones
forge install
```

Make sure to update your `remappings.txt` as described in the article to avoid issues with dependency imports.

## Usage

To create a new clone, deploy the `Factory` contract with the template contract address and use the `createClone` function. You can also predict future clone addresses and retrieve previously created clones using the provided utility functions.

## References

- [Solidity by Example - Minimal Proxy](https://solidity-by-example.org/app/minimal-proxy/)
- [EIP-1167: Minimal Proxy Standard](https://eips.ethereum.org/EIPS/eip-1167)
- [OpenZeppelin Clones Library](https://docs.openzeppelin.com/contracts/5.x/api/proxy#Clones)

For more detailed instructions, please refer to the full article linked in the repository.