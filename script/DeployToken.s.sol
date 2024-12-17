// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {WowFactoryImpl} from "contracts/WowFactoryImpl.sol";
import {console} from "forge-std/console.sol";

contract DeployToken is Script {
    address constant FACTORY = 0x69f05497485633b9b7339337Cb92C0504382EBB8;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);

        WowFactoryImpl factory = WowFactoryImpl(FACTORY);
        address newToken = factory.deploy(
            deployer,              
            address(0),            
            "ipfs://bafkreidlj3p76svhetw2l2y43aflrxwuil6y5l25rii5r3gjg3f7u5yw74",
            "TokenWars Test",     
            "TWT"               
        );

        vm.stopBroadcast();

        console.log("New token deployed to:", newToken);
    }
} 