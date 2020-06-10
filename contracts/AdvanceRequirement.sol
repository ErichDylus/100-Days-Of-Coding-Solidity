pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//work in progress -- use at own risk.
/* simple boolean Advance Requirement confirmation / condition precedent to deal closing
** owner inputs Advance Requirement details and whitelist of addresses that are controlled by the favored party
** favored party confirms when Advance Requirement is satisfied */

contract Requirement is Ownable {
    bool private requirementSatisfied = false;
    //mapping for favored party's address
    mapping(address => bool) favored;
    address[] whitelist;
    string condition;
    // event to be added when address added to whitelist || address given favored status
    // event to be added when requirementSatisfied == true
    
    //allow owner to create whitelist of favored party address[es]
    function permitFavored(address _addr) public onlyOwner {
        favored[_addr] = true;
        whitelist.push(_addr);
    }
    
    function favoredParty(address _addr) public view returns(bool) {
        return favored[_addr];
    }
    
     function revokeFavored(address _addr) public onlyOwner {
        favored[_addr] = false;
    }
        
    /*** optional modifier so only the favored party may call other functions
    modifier onlyFavored() {
        require(favored[msg.sender] == true, "Only the favored party can call this.");
        _;
    } ***/
        
    //owner sets out Advance Requirement details
    function enterCondition(string memory _reference) public onlyOwner {
        require(requirementSatisfied == false, "Advance Requirement already satisfied, cannot change details");
        condition = _reference;
    }

    function conditionContext() public view returns(string memory) {
        return condition;
    }

    function isrequirementSatisfied() public view returns(bool) {
        return requirementSatisfied;
    }
    
    //Favored party must confirm the Requirement is satisfied
    function confirmSubmit() public {
        require(favored[msg.sender] == true, "Only favored party may confirm Advance Requirement is satisfied");
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
