pragma solidity >=0.5.0 <0.9.0;
// SPDX-License-Identifier: MIT

contract myGame {


    uint public playerCount =0;
    mapping (address => Player) public players;

    struct Player {
        address playerAddress;
        string firstname;
        string lastname;
    }
    function addPlayer(string memory firstname, string memory lastname) public {
        players[msg.sender] = Player(msg.sender, firstname, lastname);
        playerCount += 1;
    }
    // function getPlayers() public view returns (uint) {
    //     return playerCount;
    // }
}