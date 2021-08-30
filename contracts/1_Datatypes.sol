pragma solidity >=0.5.0 <0.9.0;
// SPDX-License-Identifier: MIT

contract myGame {


    uint public playerCount =0;
    mapping (address => Player) public players;

    enum Level {Novice, Intermediate, Advanced}

    struct Player {
        address playerAddress;
        Level playerLevel;
        string firstname;
        string lastname;
        uint created;
    }
    function addPlayer(string memory firstname, string memory lastname) public {
        players[msg.sender] = Player(msg.sender, Level.Novice, firstname, lastname, block.timestamp);
        playerCount += 1;
    }

    function getPlayerLevel(address playerAddress) public view returns(Level){
        Player storage player = players[playerAddress];
        return player.playerLevel;

    }

    function changePlayerLevel(address playerAddress) public {
        Player storage player = players[playerAddress];
        if(block.timestamp >= player.created + 20) {
            player.playerLevel = Level.Intermediate;
        }
    }
}

