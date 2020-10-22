pragma solidity 0.6.9;

//incomplete & useless function and variable testing, etc.

contract CallandMapTest {

    string stringTest;
    string callTest;
    uint256 ledgerBalance;
    address recipient = 0xb7f49E02552751b249caE86959fD50D887708B1D;
    mapping (address => mapping (address => uint256))  public  allowance;
    mapping(address => uint256) public balances;
    mapping (address => uint) rollNo; 
      
    // Defining a function to use msg.sender to securely store roll no. 
    function setRollNO(uint256 _myNumber) public { 
        // Update our 'rollNo' mapping to store '_myNumber' under 'msg.sender' 
        rollNo[msg.sender] = _myNumber; 
    } 
      
    // Return the roll no. 
    function whatIsMyRollNumber() public view returns (uint256) { 
        // Retrieve the value stored in the sender's address, will be `0` if the sender hasn't called `setRollNO` yet 
        return rollNo[msg.sender]; 
    } 
   
   //can snoop roll number if you know the target's address
   function snoopRollNumber(address _target) public view returns (uint256) { 
        // Retrieve the value stored in the target address, will be `0` if asn't called `setRollNO` yet 
        return rollNo[_target]; 
    }
   
   function updateBalance(uint256 newBalance) public {
      balances[msg.sender] = newBalance;
   }
  /* 
   function updateBalance() public returns (uint256) {
      LedgerBalance ledgerBalance = new LedgerBalance();
      ledgerBalance.updateBalance(10);
      return ledgerBalance.balances(address(this));
   } */
    
    
    function calldataTest(string calldata _exampleString, string calldata _intTest) external returns (string memory, string memory) {
        stringTest = _exampleString;
        internalTest(_intTest);
        return (stringTest, callTest);
    }
    
    function internalTest(string calldata _internalCall) internal {
        callTest = _internalCall;
    }
    
    //check gas remaining
    function checkGasAndSig() public view returns(uint256, bytes4){
        uint256 gasRemaining = gasleft();
        return(gasRemaining, msg.sig);
    }
}
