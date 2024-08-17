// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import {ERC20Upgradeable} from "@openzeppelin-contracts-upgradeable-5.0.2/token/ERC20/ERC20Upgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin-contracts-upgradeable-5.0.2/access/OwnableUpgradeable.sol";

contract ClonedERC20 is OwnableUpgradeable, ERC20Upgradeable {

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice Initializes the ClonedERC20 contract
    /// @dev This function should be called immediately after deployment
    /// @param initialOwner The address that will be set as the initial owner of the contract
    /// @param initialName The name of the token
    /// @param initialSymbol The symbol of the token
    function initialize(
        address initialOwner, 
        string memory initialName,
        string memory initialSymbol
    ) external initializer {
        __ERC20_init(initialName, initialSymbol);
        __Ownable_init(initialOwner);
    }

    function mint(uint256 amount) external onlyOwner {
        _mint(msg.sender, amount);
    }

    function mintTo(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}