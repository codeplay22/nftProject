// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicnft} from "../../script/DeployBasicnft.s.sol";
import{console} from "forge-std/console.sol";
contract BasicnftTest is Test {

    DeployBasicnft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant BERNARD_URI = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public{
        deployer = new DeployBasicnft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // assert(expectedName == actualName);
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance () public {
        vm.prank(USER);
        basicNft.mintNft(BERNARD_URI);
        // console.log(basicNft.balanceOf(USER));
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(BERNARD_URI)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));

    }
}