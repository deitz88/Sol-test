pragma solidity >=0.5.0 <0.9.0;
// SPDX-License-Identifier: MIT


contract SimpleAuction{

    // parameters for auction
    address payable public beneficiary;
    uint public auctionEndTime;

    //current state of aution
    address public highestBidder;
    uint public highestBid;

    //keeps track of how much and who has been outbid
    mapping (address => uint) public pendingReturns;

    bool ended = false;

    event HighestBidIncrease(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary){
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() public payable { 
        if(block.timestamp > auctionEndTime){
            revert ("the auction has already ended");
        }

        if(msg.value <= highestBid){
            revert("bid too low");
        }

        if(highestBid != 0){
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncrease(msg.sender, msg.value);
    }

    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if(amount > 0){
            pendingReturns[msg.sender] = 0;

            if(!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function auctionEnd() public payable {
        if(block.timestamp < auctionEndTime){
            revert ("Auction has not ended yet");
        }

        if(ended){
            revert ("func auctionEnded has already been called");
        }
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transder(highestBid);
    }

}