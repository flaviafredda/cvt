// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

interface IERC721 {
    function balanceOf(address owner) external view returns (uint256 balance);
}

interface INFTContract {
    function balanceOf(address owner) external view returns (uint256);
}

contract CommunityValueToken is ERC20, ERC20Permit {
    IERC721 public soulBoundToken;

    INFTContract soulBound = INFTContract(0xd9145CCE52D386f254917e481eB44e9943F39138);


    constructor(uint256 initialSupply) ERC20("CommunityValueToken", "CVT") 
        ERC20Permit("CommunityValueToken") {
        _mint(msg.sender, initialSupply);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        address owner = _msgSender();
        _transferInternal(owner, to, value);
        return true;
    } 

    function _transferInternal(address from, address to, uint256 value) internal  {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _beforeTokenTransfer(from, to);

        _update(from, to, value);
    }
        
    function _beforeTokenTransfer(address from, address to) internal view {
        
        // Require that both `from` (if not minting) and `to` addresses own at least one SoulBound token
        if (from != address(0)) { // Skip for minting
            require(soulBound.balanceOf(msg.sender) != 0, "Sender does not own an NFT");
        }
    }
    
}

