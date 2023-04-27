// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";


contract SoonToken is ERC20,Ownable,Pausable{

  uint256 public constant _cap = 1000000000*(10**18);

   constructor() ERC20("SOON", "SOON") {}

    function mint(address account, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= _cap, "SoonToken._mint: cap exceeded");
        super._mint(account, amount);
    }

    function pause() external onlyOwner {
        _pause();
    }

    /*
    _unpause literally derives from pausable.
    */
    function unpause() external onlyOwner{
        _unpause();
    }



    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        require(!paused(), "ERC20Pausable: token transfer while paused");
    }


   
}