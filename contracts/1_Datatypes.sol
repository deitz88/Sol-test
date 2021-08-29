pragma solidity >=0.5.0 <0.9.0;
// SPDX-License-Identifier: MIT

contract myGame {

    Player[] public players;

    struct Player {
        string firstname;
        string lastname;
    }
    function addPlayer(string memory firstname, string memory lastname) public {
        players.push(Player(firstname, lastname));
    }
}