pragma solidity ^0.6.0;

// in process, not recommended to be used for any purpose

contract Campaign {

  struct Request {
      string description;
      uint value;
      address recipient;
      bool complete;
      uint approvalCount;
      mapping(address => bool) approvals;
  }
  
  Request[] public requests;
  address public manager;
  uint minimumContribution;
  mapping(address => bool) public approvers;
  
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
      approvers[msg.sender] = true;
  }
  
  function createRequest(string memory description, uint value, address recipient) public restricted {
      Request memory newRequest = Request({
         description: description,
         value: value,
         recipient: recipient,
         complete: false,
         approvalCount  = 0
      });
      requests.push(newRequest);
  }
  
  function approveRequest(uint index) public {
      Request storage request = requests[index];
      require(approvers[msg.sender]);
      require(!request.approvals[msg.sender]);
      request.approvals[msg.sender] = true;
      request.approvalCount++;
  }
}
