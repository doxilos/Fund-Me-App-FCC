// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error NotOwner();

/** @title A contraact for crowd funding
*   @author Nurbaki Vural
*   @notice This contract is to demo a sample funding contract
*/

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public s_addressToAmountFunded;
    address[] public s_funders;

    address public immutable i_owner;
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;

    AggregatorV3Interface public s_priceFeed;
    
    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    modifier onlyOwner {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }
    
    // function withdraw() public onlyOwner {
    //     for (uint256 funderIndex=0; funderIndex < s_funders.length; funderIndex++){
    //         address funder = s_funders[funderIndex];
    //         s_addressToAmountFunded[funder] = 0;
    //     }
    //     s_funders = new address[](0);
    //     (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    //     require(callSuccess, "Call failed");
    // }
    //
    function withdraw() public payable onlyOwner {
        address[] memory funders = s_funders;
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }

        s_funders = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success);
    }
}


