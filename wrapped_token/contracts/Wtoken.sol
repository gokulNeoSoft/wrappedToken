// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WrappedToken is ERC20{
    address public tokenAddress;

    constructor(address token) ERC20("Wtoken", "WTK") {
        tokenAddress = token;
    }

    function mint(uint amt)external {
        uint balOfSender =  IERC20(tokenAddress).balanceOf(msg.sender);
        require(balOfSender>amt,"INSUFFICIENT TOKENS!");
        IERC20(tokenAddress).transferFrom(msg.sender, address(this),decimalConvert(amt));
        _mint(msg.sender, decimalConvert(amt));
    }

    function burn(uint amt)external {
        require(balanceOf(msg.sender)>amt,"LOW BALANCE!");
        IERC20(tokenAddress).transfer(msg.sender,decimalConvert(amt));
        _burn(msg.sender, decimalConvert(amt));
    }

    function decimalConvert (uint amount) internal pure returns (uint res){
        res = amount * (10 ** 18);
    }

} 