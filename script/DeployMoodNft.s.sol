// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script,console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script{

    function run() external returns (MoodNft){
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageUri(sadSvg),
            svgToImageUri(happySvg)
        );
        vm.stopBroadcast();
        console.log("hello from run function in DeployMoodNft.s.sol");
        return moodNft;
    }

    function svgToImageUri(string memory svg) public view returns(string memory){
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        console.log(svgBase64Encoded);
        console.log("hello from svgToImageUri    function in DeployMoodNft.s.sol");
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }


}