
// Get funds from users
// Withdraw funds
// Sert a minimun funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimunUSD = 50 * 1e18;


    function fund() public payable {
        // Want to be able to set a minimum dund amout
        // 1. How do we send ETH to this contract?
        // msg = checker, sees if the value is greater then is required;
       require(getConversionRate(msg.value) >= minimunUSD, "Didn't send enough"); // 1e18 = 1 * 10 ** 18;
       //Note: What is Reverting? = Undo any action before, and send remaining gas back.
    }

    function getPrice() public view returns(uint256){
      // ABI 
      // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
      AggregatorV3Interface price = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = price.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
      uint256 ethPrice = getPrice();
      uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
      return ethAmountInUSD;
    }

  //  function witdraw() external {}
}