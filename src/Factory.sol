// SPDX-License-Identifier: MIT

pragma solidity 0.8.26; 

import {Clones} from "@openzeppelin-contracts-5.0.2/proxy/Clones.sol";
import {ClonedERC20} from "./ClonedERC20.sol";

contract Factory {

    using Clones for address;

    address public immutable contractTemplate;
    uint256 private cloneIndex;

    event CloneCreated(address memeAddress);

    /// @notice Initializes the Factory contract with a template contract address
    /// @param template The address of the contract to be cloned
    constructor(address template) {
        contractTemplate = template;
    } 

    /// @notice Creates a new clone of the contract template
    /// @dev Increments the clone index and uses it to create a deterministic clone
    /// @return The address of the newly created clone
    function createClone(string memory name, string memory symbol) external payable returns (address) {
        uint256 cloneId = cloneIndex;
        cloneIndex = cloneIndex + 1;
        
        address clone = contractTemplate.cloneDeterministic(bytes32(cloneId));
        //initialize the contract
        ClonedERC20(clone).initialize(msg.sender, name, symbol);

        emit CloneCreated(clone);

        return clone;
    }

    /// @notice Predicts the address of the next clone to be created
    /// @return The predicted address of the next clone
    function predictNextAddress() external view returns (address) {
        return Clones.predictDeterministicAddress(contractTemplate, bytes32(cloneIndex));
    }

    /// @notice Gets the address of a clone by its index
    /// @param index The index of the clone
    /// @return The address of the clone at the given index
    function getCloneAddress(uint256 index) external view returns (address) {
        return Clones.predictDeterministicAddress(contractTemplate, bytes32(index));
    }

    /// @notice Gets the total number of clones created
    /// @return The current clone count
    function getCloneCount() external view returns (uint256) {
        return cloneIndex;
    }
}