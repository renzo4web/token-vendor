pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import './YourToken.sol';

contract Vendor is Ownable {
  YourToken public seeAdToken;

    uint256 public constant tokensPerEth = 100;
    event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);

    constructor(address tokenAddress) public {
    seeAdToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
    function buyTokens() public payable {
        uint256 amountOfEth = msg.value;
        uint256 amountOfTokens = amountOfEth * tokensPerEth;

        require( seeAdToken.balanceOf(address(this)) >= amountOfTokens, "Vendor doesn't have tokens to delivered");

        seeAdToken.transfer(msg.sender, amountOfTokens );
        emit BuyTokens( msg.sender,amountOfEth,amountOfTokens);
    }


  // ToDo: create a withdraw() function that lets the owner withdraw ETH
    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer((address(this)).balance);
    }

  // ToDo: create a sellTokens() function:
    function sellTokens() payable public {
        // check contract balance have liquidity to swap
        uint256 amountOfToken = msg.value;
        uint256 amountOfTokens = amountOfToken / tokensPerEth;

        seeAdToken.transfer(msg.sender, amountOfTokens );
    }
}
