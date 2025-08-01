// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DemoNFT} from "../src/NFT.sol";

contract DeployNFT is Script {
    DemoNFT public demoNFT;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        demoNFT = new DemoNFT();

        vm.stopBroadcast();
    }
}
