pragma solidity >=0.5.0 <0.9.0;
// SPDX-License-Identifier: MIT

contract Mask {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() public {
        minter = msg.sender;
    }

    function mint(address reciever, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[reciever] += amount;
    }

    function send(address reciever, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Sent(msg.sender, reciever, amount);
    }
}