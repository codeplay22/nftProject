// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;
import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";

contract DeployBasicnft is Script {
    function run() external returns (BasicNft) {
        vm.startBroadcast();
        BasicNft basicnft = new BasicNft();
        vm.stopBroadcast();
        return basicnft;
    }
}