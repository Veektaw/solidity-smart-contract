// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

import "contracts/PriceConverter.sol";

error NotOwner();

contract fundMe {

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 60 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    address public immutable i_owner;


    constructor () {
        i_owner = msg.sender;
    }

    function fund () public payable {

        // Requires an amount of ETH to USD to pass
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough ETH");

        // Add address of the funder to an array
        funders.push(msg.sender);

        // Map the value of the fund to the funder
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw () public onlyOwner {

        // Loop through the array of funders
        for (uint256 fundersIndex = 0; fundersIndex < funders.length; ++fundersIndex) {
            address funder = funders[fundersIndex];
            addressToAmountFunded [funder] = 0;

            // Reset the funders array
            funders = new address[](0);


            // trasnfer the funds using 'transfer'

            // payable (msg.sender). transfer(address(this).balance);

            // Transfer the funds using 'send'

            // bool sendSuccess = payable (msg .sender). send (address (this).balance);
            // require (sendSuccess, "Send failed");


            // Transfer the funds using 'call'
            (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
            require (callSuccess, "Call failed");
        }
    }


    modifier onlyOwner {
        // Check if the person calling the withdraw function is the owner of the contract

        // require(msg.sender == i_owner, "You are not the owner");

        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }


    fallback() external payable {
        fund();
    }

}