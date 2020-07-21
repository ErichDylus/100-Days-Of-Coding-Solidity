pragma solidity ^0.6.0;

// in process, for demonstration only, not recommended to be used for any purpose

contract Campaign {

  struct Request {
      string storage description;
      uint value;
      address recipient;
      bool complete;
  }
  
  Request[] public requests;
  address public manager;
  uint minimumContribution;
  address[] public approvers;
  
  modifier restricted() {
    require(msg.sender == manager);
    _;
  }
  
  constructor(uint minimum) public {
      manager = msg.sender;
      minimumContribution = minimum;
  }
  
  function contribute() public payable {
      require(msg.value > minimumContribution);
      approvers.push(msg.sender);
  }
  
  function createRequest(string memory description, uint value, address recipient) public restricted {
      Request newRequest = Request({
         description: description,
         value: value,
         recipient: recipient,
         complete: false
      });
      requests.push(newRequest);
  }
  
}
