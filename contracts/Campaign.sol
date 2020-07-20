pragma solidity ^0.6.0;

// in process, not recommended to be used for any purpose

contract Campaign {

  struct Request {
      string description;
      uint value;
      address recipient;
      bool complete;
  }
  
  address public manager;
  uint minimumContribution;
  address[] public approvers;
  
  constructor(uint minimum) public {
      manager = msg.sender;
      minimumContribution = minimum;
  }
  
  function contribute() public payable {
      require(msg.value > minimumContribution);
      approvers.push(msg.sender);
  }
  
}
