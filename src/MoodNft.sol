// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error Mood_Nft__CantFlipMoodIfNotOwner();
    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("MoodNft", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        //only want the nft owner to be able to change the mood.
        // if ((!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId))){
            
        //     revert Mood_Nft__CantFlipMoodIfNotOwner();
        // } 
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert Mood_Nft__CantFlipMoodIfNotOwner();
        }

        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            
            s_tokenIdToMood[tokenId] == Mood.SAD;
        }else{
            s_tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        //Meta data of our token
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }
    
    return
        string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":  "',
                            name(),
                            '", "description":"An NFT that reflects the owners mood."," attributes":[{"trait_type": "moodiness","value":100}],"image": "',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }


}
