// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Factory} from "../src/Factory.sol";
import {ClonedERC20} from "../src/ClonedERC20.sol";

contract FactoryTest is Test {
    Factory public factory;
    ClonedERC20 public implementation;

    address public deployer;
    address public alice;
    address public bob;

    function setUp() public {
        implementation = new ClonedERC20();
        factory = new Factory(address(implementation));

        deployer = makeAddr("deployer");
        deal(deployer, 100 ether);
        alice = makeAddr("alice");
        deal(alice, 100 ether);
        bob = makeAddr("bob");
        deal(bob, 100 ether);
    }

    function test_deploy() public {
        factory.createClone("Test", "TEST");
        assertEq(factory.getCloneCount(), 1);
    }

    function test_deploy_alice() public {
        vm.startPrank(alice);
        address clone = factory.createClone("Test", "TEST");
        ClonedERC20(clone).mint(10 ether);
        vm.stopPrank();
        assertEq(ClonedERC20(clone).balanceOf(alice), 10 ether);
    }

    function test_non_owner_mint() public {
        vm.prank(alice);
        address clone = factory.createClone("Test", "TEST");
        vm.prank(bob);
        vm.expectRevert();
        ClonedERC20(clone).mint(10 ether);
        vm.stopPrank();
    }

    function testFuzz_getCloneAddress(uint256 x) public {
        address predictedClone = factory.getCloneAddress(x);
        address actualClone = predictDeterministicAddress(address(implementation), bytes32(x), address(factory));
        assertEq(predictedClone, actualClone);
    }

    function predictDeterministicAddress(
        address implementation,
        bytes32 salt,
        address deployer
    ) internal pure returns (address predicted) {
        /// @solidity memory-safe-assembly
        assembly {
            let ptr := mload(0x40)
            mstore(add(ptr, 0x38), deployer)
            mstore(add(ptr, 0x24), 0x5af43d82803e903d91602b57fd5bf3ff)
            mstore(add(ptr, 0x14), implementation)
            mstore(ptr, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73)
            mstore(add(ptr, 0x58), salt)
            mstore(add(ptr, 0x78), keccak256(add(ptr, 0x0c), 0x37))
            predicted := keccak256(add(ptr, 0x43), 0x55)
        }
    }
}
