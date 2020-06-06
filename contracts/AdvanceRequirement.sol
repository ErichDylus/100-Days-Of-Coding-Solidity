pragma solidity ^0.5.17;

//work in progress, based off of lexDAO's Shame.sol -- use at own risk.
//simple boolean Advance Requirement confirmation / condition precedent to deal closing

contract Requirement {
    bool private requirementSatisfied = false;
    //this should be inputted by favored party; also need mapping for favored party's address
    string condition;
    
    //set out Advance Requirement details
    function context() public view returns(string memory) {
        //add ability for favored party to input string condition, only once
        return "Section 4 of the Loan Agreement";
    }

    function isrequirementSatisfied() public view returns(bool) {
        return requirementSatisfied;
    }
    
    //Favored Party must confirm the Requirement is satisfied
    function confirmSubmit() public {
        require(msg.sender == 0xb7f49E02552751b249caE86959fD50D887708B1D, "Caller not favored party");
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
