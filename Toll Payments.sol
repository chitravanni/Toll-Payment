// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TollCollection {
    struct TollData {
        uint timestamp;
        address collectedBy;
        uint amount;
    }

    mapping(address => mapping(uint => TollData)) public tolls;

    // Payable function to handle toll payments
    function payTollAmount(uint highwayId) public payable {
        require(msg.value > 0, "You must send some Ether to pay the toll");

        tolls[msg.sender][highwayId].timestamp = block.timestamp;
        tolls[msg.sender][highwayId].collectedBy = msg.sender;
        tolls[msg.sender][highwayId].amount += msg.value;
    }

    // Retrieve toll data for a specific highwayId
    function getToll(uint highwayId) public view returns (TollData memory) {
        return tolls[msg.sender][highwayId];
    }

    // Receive function to accept Ether
    receive() external payable {}

    // Fallback function for any undefined calls
    fallback() external payable {}
}