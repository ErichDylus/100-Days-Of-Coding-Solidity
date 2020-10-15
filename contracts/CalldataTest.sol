pragma solidity 0.6.9;

//in progress and incomplete

contract CallandMapTest {

    string stringTest;
    string callTest;
    address recipient = 0xb7f49E02552751b249caE86959fD50D887708B1D;
    mapping (address => mapping (address => uint256))  public  allowance;
    mapping(address => uint256) public balances;

   function updateBalance(uint256 newBalance) public {
      balances[msg.sender] = newBalance;
   }
   
   function updateBalance() public returns (uint256) {
      LedgerBalance ledgerBalance = new LedgerBalance();
      ledgerBalance.updateBalance(10);
      return ledgerBalance.balances(address(this));
   }
    
    
    function memoryTest(string memory _exampleString) public returns (string memory) {
        stringTest = _exampleString;  // You can modify memory
        string memory newString = stringTest;  // You can use memory within a function's logic
        return newString;  // You can return memory
        allowance[msg.sender][recipient] = 1;
    }

    function calldataTest(string calldata _exampleString, string calldata _intTest) external returns (string memory, string memory) {
        stringTest = _exampleString;
        internalTest(_intTest);
        return (stringTest, callTest);
    }
    
    function internalTest(string calldata _internalCall) internal {
        callTest = _internalCall;
    }
}
