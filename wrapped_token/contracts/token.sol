// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Gtoken is  Ownable,ERC20 {
    constructor() ERC20("Gtoken", "GTK") {
    }

    function mint(address to, uint256 amount) public onlyOwner {
        uint decAmount = decimalConvert(amount);
        _mint(to, decAmount);

    }

    function decimalConvert (uint amount) internal view returns (uint res){
        res = amount * (10 ** uint256(decimals()));
    }
    
}
