// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public addressToMountFunded;

    function fund() public payable {
        addressToMountFunded[msg.sender] += msg.value;
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43); // BTC-USD
        return priceFeed.version();
    }
}