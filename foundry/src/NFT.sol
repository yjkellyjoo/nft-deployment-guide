// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title DemoNFT
 * @dev A simple demo NFT contract with owner-only minting
 */
contract DemoNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("Demo NFT", "DEMO") Ownable(msg.sender) {}

    /**
     * @dev Mints a new NFT (owner only)
     * @param to The address to mint the NFT to
     */
    function mint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        _safeMint(to, tokenId);
    }

    /**
     * @dev Returns the total number of tokens minted
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter;
    }
}
