// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {WowFactoryImpl} from "contracts/WowFactoryImpl.sol";
import {Wow} from "contracts/Wow.sol";
import {BondingCurve} from "contracts/BondingCurve.sol";
import {console} from "forge-std/console.sol";

contract Deploy is Script {
    // Base Sepolia addresses from Uniswap docs
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant UNISWAP_V3_POSITION_MANAGER = 0x27F971cb582BF9E50F397e4d29a5C7A34f11faA2;
    address constant UNISWAP_V3_ROUTER = 0x94cC0AaC535CCDB3C01d6787D6413C739ae12bc4;
    address constant PROTOCOL_REWARDS = 0x68E9e94Fb77a2D4C630CCC69c66715e9740B5d11;
    address constant PROTOCOL_FEE_RECIPIENT = 0x0000c1E5C9d12c8c52eb319AF11dA44bb84779d2;
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Step 1: Deploy implementation contracts
        console.log("Deploying implementation contracts...");
        
        // BondingCurve bondingCurve = new BondingCurve();
        // console.log("BondingCurve deployed to:", address(bondingCurve));

        Wow wowImpl = new Wow(
            PROTOCOL_FEE_RECIPIENT,
            PROTOCOL_REWARDS,
            WETH,
            UNISWAP_V3_POSITION_MANAGER,
            UNISWAP_V3_ROUTER
        );
        console.log("Wow Implementation deployed to:", address(wowImpl));

        vm.stopBroadcast();

        console.log("\nTo deploy the factory, use these addresses:");
        console.log("tokenImplementation:", address(wowImpl));
        // console.log("bondingCurve:", address(bondingCurve));
    }
}