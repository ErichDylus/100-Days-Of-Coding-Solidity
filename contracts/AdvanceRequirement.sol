pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//work in progress -- use at own risk.
//simple boolean Advance Requirement confirmation / condition precedent to deal closing

contract Requirement is Ownable {
    bool private requirementSatisfied = false;
    //mapping for favored party's address
    mapping(address => bool) favored;
    address whitelist;
    string condition;
    
    //allow owner to create whitelist of favored party address[es]
    function permitAccess(address _addr) public onlyOwner {
        favored[_addr] = true;
    }
    
    function favoredParty(address _addr) public view returns(bool) {
        return favored[_addr];
    }
    
     function revokeAccess(address _addr) public onlyOwner {
        favored[_addr] = false;
    }
    
    //set out Advance Requirement details
    function enterCondition(string memory _reference) public {
        //add ability for favored party to input string condition
        require(favoredParty(favored), "Caller not favored party");
        condition = _reference;
    }

    function conditionContext() public view returns(string memory) {
        return condition;
    }

    function isrequirementSatisfied() public view returns(bool) {
        return requirementSatisfied;
    }
    
    //Favored Party must confirm the Requirement is satisfied
    function confirmSubmit() public {
        require(favoredParty(favored), "Caller not favored party");
        require(requirementSatisfied == false, "Advance Requirement already satisfied");
        requirementSatisfied = true;
    }

    function satisfyRequirement() public view returns(string memory) {
        if(requirementSatisfied == true) {
            return "Advance Requirement is satisfied";
        } else {
            return "Advance Requirement remains outstanding";
        }
    }
}
