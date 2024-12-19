// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {WowFactoryImpl} from "contracts/WowFactoryImpl.sol";
import {WowFactory} from "contracts/proxy/WowFactory.sol";
import {console} from "forge-std/console.sol";

contract DeployFactory is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);

        // Use existing implementation
        address implementation = 0x6ffDDfc68249B04469D3676fb864ee7b57AaB4B2;

        // Prepare initialization data
        bytes memory initData = abi.encodeWithSelector(
            WowFactoryImpl.initialize.selector,
            deployer  // owner
        );

        // Deploy proxy using our custom WowFactory
        WowFactory proxy = new WowFactory(
            implementation,
            initData
        );

        vm.stopBroadcast();

        console.log("Using WowFactoryImpl at:", implementation);
        console.log("WowFactory Proxy deployed to:", address(proxy));
    }
} 