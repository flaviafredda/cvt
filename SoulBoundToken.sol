// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.0/utils/Counters.sol"; 


contract Soulbound is ERC721, Ownable {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(address initialOwner) ERC721("SoulBound", "SBT")  Ownable(initialOwner) {}

    function _beforeTokenTransfer(address from, address to, uint256 /*tokenId*/)
    internal virtual 
    {
        require(from == address(0), "Token not transferable");
        require(to == address(0), "Token not transferable");
    } 

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    /*function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }*/

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
