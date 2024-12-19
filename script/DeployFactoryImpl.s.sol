// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {WowFactoryImpl} from "contracts/WowFactoryImpl.sol";
import {console} from "forge-std/console.sol";

contract DeployFactory is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy factory using existing implementation addresses
        address tokenImplementation = 0x125D935F8e6c8ce7743DE5509084f26C347bc627;  // Wow implementation
        address bondingCurve = 0x3d0476f0dcAA440c98864fe08E52fBE0257b509f;         // BondingCurve

        WowFactoryImpl factory = new WowFactoryImpl(
            tokenImplementation,
            bondingCurve
        );

        vm.stopBroadcast();

        console.log("WowFactory deployed to:", address(factory));
    }
} 