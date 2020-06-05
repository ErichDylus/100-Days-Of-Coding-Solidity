pragma solidity ^0.5.17;

//work in progress, based off of lexDAO's Shame.sol -- use at own risk.
//simple boolean Advance Requirement confirmation as condition precedent to GATS deal closing

contract  {
    bool private requirementSatisfied = false;
    
    //set out Advance Requirement details
    function context() public pure returns(string memory) {
        return "[Advance Requirement explanation]";
    }

    function isrequirementSatisfied() public view returns(bool) {
        return requirementSatisfied();
    }
    
    //Favored Party must confirm the Requirement is satisfied
    function confirmSubmit() public {
        require(msg.sender == [favored party address], "Caller not favored party");
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
