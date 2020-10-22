pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

//simple expiration date boolean, input term length in calendar days
//@dev set expired to true after inputted number of calendar days until expiration

contract Expiration {
    
    using SafeMath for uint256;
    using SafeMath for uint8;
    
    uint256 effectiveTime;
    uint256 expirationTime;
    uint256 daysUntilExpiry;
    uint256 secondsUntilExpiry;
    uint256 constant DAY_IN_SECONDS = 86400;
    bool isExpired;
    
    event Expired(uint256 expirationTime, bool isExpired);
    
    constructor(uint8 _daysUntilExpiration) public {
        require(_daysUntilExpiration > 0,"Expiry Date cannot be today");
        effectiveTime = now;
        isExpired = false;
        expirationTime = effectiveTime + (DAY_IN_SECONDS * uint256(_daysUntilExpiration));
    }
    
    function checkExpiryTime() public returns(uint256, uint256, uint256){
        daysUntilExpiry = ((expirationTime - now)/DAY_IN_SECONDS);
        //seconds until expiry more precise, to avoid roundoff of the float in daysUntilExpiry
        secondsUntilExpiry = expirationTime - now;
        return(daysUntilExpiry, secondsUntilExpiry, expirationTime);
    }
    
    function checkIfExpired() public returns(bool){
        if (expirationTime <= now) {
            isExpired = true;
            emit Expired(expirationTime, isExpired);
        } else {
            isExpired = false;
        }
        return(isExpired);
    }
}
