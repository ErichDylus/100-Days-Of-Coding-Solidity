pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/* work in progress -- USE AT OWN RISK.
** simple boolean Advance Requirement confirmation / condition precedent to deal closing
** owner inputs Advance Requirement details and assigns favored party addresses
** favored party confirms when Advance Requirement is satisfied */

contract Requirement is Ownable {
    
    bool private requirementSatisfied = false;
    mapping(address => bool) favored;
    address[] whitelist;
    string condition;
    
    event whitelistAdded(address indexed _addr);
    event Confirmed();
    
    //allow owner to assign favored status to address, address added to whitelist of favored party addresses
    function permitFavored(address _addr) public onlyOwner {
        favored[_addr] = true;
        whitelist.push(_addr);
        emit whitelistAdded(_addr);
    }
    
    //check if address is a favored party
    function favoredParty(address _addr) public view returns(bool) {
        return favored[_addr];
    }
    
    //owner may revoke favored status 
    function revokeFavored(address _addr) public onlyOwner {
        favored[_addr] = false;
    }
        
    /*** optional modifier so only the favored party may call other functions
    modifier onlyFavored() {
        require(favored[msg.sender] == true, "Only the favored party can call this.");
        _;
    } ***/
        
    //owner sets out Advance Requirement condition details or reference to provision in underlying documentation
    function enterCondition(string memory _reference) public onlyOwner {
        require(requirementSatisfied == false, "Advance Requirement already satisfied, details may not be changed");
        condition = _reference;
    }

    //check details of Advance Requirement / condition precedent
    function conditionContext() public view returns(string memory) {
        return condition;
    }

    //check if the requirement/condition is satisfied (bool)
    function isRequirementSatisfied() public view returns(bool) {
        return requirementSatisfied;
    }

    //check if the requirement/condition is satisfied (string)
    function isRequirementSatisfiedReply() public view returns(string memory) {
        if(requirementSatisfied == true) {
            return "Advance Requirement is satisfied";
        } else {
            return "Advance Requirement remains outstanding";
        }
    }
    
    //favored party submits confirmation that the requirement/condition is satisfied
    function confirmSubmit() public {
        require(favored[msg.sender] == true, "Only the favored party may confirm Advance Requirement is satisfied");
        require(requirementSatisfied == false, "Advance Requirement already satisfied");
        requirementSatisfied = true;
        emit Confirmed();
    }
}
