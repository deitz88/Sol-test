pragma solidity >=0.5.0 <0.9.0;
// SPDX-License-Identifier: MIT

contract TokenTown {
    uint contractStart;
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);
    
    //----------------Modifiers---------------//

    modifier onlyOwner {
        require(msg.sender == minter, "Only minter can call this function");
        _;
    }

    modifier isAmountSufficient(uint amount) {
        require(amount < 1e60);
        _;
    }

    modifier isGreaterThan(uint amount) {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        _;
    }


    //-----------------------***-----------------------//

    //constructor of coin
    constructor() public {
        minter = msg.sender;
        contractStart = block.timestamp;
    }
    //mint coins
    function mint(address reciever, uint amount) public onlyOwner isAmountSufficient(amount) {
        balances[reciever] += amount;
    }

    //send coins
    function send(address reciever, uint amount) public isGreaterThan(amount) {
        require(block.timestamp >= contractStart + 604800); //one week after mint
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Sent(msg.sender, reciever, amount);
    }
}