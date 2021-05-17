//simple deposit as liquidated damages clause

pragma solidity ^0.8.0;

    //buyer initiates escrow with description, deposit amount & offer expiration, and designates recipient seller
    constructor(string memory _description, uint256 _deposit, address payable _seller, uint256 _secondsUntilExpiry) payable {
        require(msg.value >= deposit, "Submit deposit amount, which the parties agree will serve as liquidated damages in event of breach");
        uint256 liqDamagesAmt = msg.value; 
        owner = payable(address(msg.sender));
        effectiveTime = uint256(block.timestamp);
