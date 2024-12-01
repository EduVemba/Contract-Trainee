
// Get funds from users
// Withdraw funds
// Sert a minimun funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {
    
    using PriceConverter for uint256;

    uint256 public minimunUSD = 50 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable { 
       require(msg.value.getConversionRate() >= minimunUSD,
        "Didn't send enough"); 
       funders.push(msg.sender);
       addressToAmountFunded[msg.sender] = msg.value;
    }

    function witdraw() public  {
       for (uint256 funderIndex = 0 ; funderIndex <= funders.length; funderIndex++)  {
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
       }
       //reset Array
       funders = new address[](0);
       //actually withdraw the funds

       // transfer
       payable (msg.sender).transfer(address(this).balance); // with transfer if not true will revert

       //send
      bool sendSuccesseful = payable (msg.sender).send(address(this).balance); // with send if not true will view as a bool value to see if the condition is true or false (more user manualy)
      require(sendSuccesseful, "Send failed");
       //call
       (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");// we can call a function
       require(callSuccess,"Call failed");
    }
}