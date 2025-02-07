// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Campain {
    string public title;
    uint256 public requiredAmount;
    string public image;
    address payable public owner;
    uint256 public receivedAmount;
    event DonatedPeoples (address indexed  donar , uint indexed  amount , uint indexed  timestamp);
    constructor(
        string memory _title,
        uint256 _amount,
        string memory _imageUrl,
        uint256 _AmounrRecieved
    ) {
        title = _title;
        requiredAmount = _amount;
        image = _imageUrl;
        owner = payable(msg.sender);
        receivedAmount = _AmounrRecieved;
    }


    function Donate() public payable {
        require(msg.value > 0, "You must send some ETH to donate!");

        owner.transfer(msg.value); // Correct ETH transfer

        receivedAmount+=msg.value;
        emit  DonatedPeoples(msg.sender, msg.value, block.timestamp);
    }
}
