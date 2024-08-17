// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Factory} from "../src/Factory.sol";
import {ClonedERC20} from "../src/ClonedERC20.sol";

contract FactoryScript is Script {
    Factory public factory;
    ClonedERC20 public implementation;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        implementation = new ClonedERC20();
        factory = new Factory(address(implementation));

        vm.stopBroadcast();
    }
}
