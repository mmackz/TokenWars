// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {Wow} from "contracts/Wow.sol";
import {IWow} from "contracts/interfaces/IWow.sol";
import {console} from "forge-std/console.sol";

contract BuyToken is Script {
    address constant TOKEN = 0x6f725F3C39A6e65b336Db0af1B65eb34Ab9a8ae3;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);

        Wow token = Wow(payable(TOKEN));
        
        // Using a very small amount to get a reasonable number of tokens
        uint256 ethAmount = 0.00021 ether; // 1 gwei
        console.log("ETH amount to spend:", ethAmount);
        
        // Get quote first
        uint256 expectedTokens = token.getEthBuyQuote(ethAmount);
        console.log("Expected tokens:", expectedTokens);

        // Account for 1% fee slippage
        uint256 minTokens = (expectedTokens * 99) / 100;
        console.log("Minimum accepted tokens:", minTokens);

        token.buy{value: ethAmount}(
            deployer,              
            deployer,              
            address(0),            
            "gm tokenwars",                    
            IWow.MarketType.BONDING_CURVE,
            minTokens,             
            0                      
        );

        vm.stopBroadcast();

        console.log("Buy transaction completed");
    }
} 