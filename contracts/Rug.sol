//mimicking https://twitter.com/bantg/status/1359823664854794241/photo/1

pragma solidity >=0.8;

contract RugPull {
    
  address rugAddress = address(this);
  address payable admin;
  bool isRugged;
  
  event Rugged();
  
  modifier adminOnly() {
    require(msg.sender == admin, "admin only");
    _;
  }
  
  constructor(address payable _admin) payable {
      require(msg.value >= deposit, "Submit deposit amount");
      admin = _creator;
      isRugged = false;
  }
  
  function rugPull() public adminOnly {
        if (rugAddress.balance > 0) {
            admin.transfer(rugAddress.balance);
            isRugged = true;
            emit Rugged();
        } else {
            isRugged = false;
        }
    }
}
