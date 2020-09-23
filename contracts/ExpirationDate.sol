pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

// set expired to true after inputted number of days until expiration

contract Expiration {
    
    using SafeMath for uint256;
    using SafeMath for uint32;
    
    uint256 effectiveTime;
    uint256 expirationTime;
    uint32 constant DAY_IN_SECONDS = 86400;
    bool isExpired;
    
    event Expired(uint256 expirationTime, bool isExpired);
    
    constructor() public {
        effectiveTime = now;
        isExpired = false;
    }
    
    function inputTerm(uint8 _daysUntilExpiration) public returns(uint256){
        expirationTime = effectiveTime + uint256(DAY_IN_SECONDS * uint32(_daysUntilExpiration));
        return(expirationTime);
    }
    
    function expirationDate() public view returns(uint256){
        return(expirationTime);
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
