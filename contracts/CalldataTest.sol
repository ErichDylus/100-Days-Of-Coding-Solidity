pragma solidity 0.6.9;

contract Test {

    string stringTest;
    string callTest;
    
    function memoryTest(string memory _exampleString) public returns (string memory) {
        stringTest = _exampleString;  // You can modify memory
        string memory newString = stringTest;  // You can use memory within a function's logic
        return newString;  // You can return memory
    }

    function calldataTest(string calldata _exampleString, string calldata _intTest) external returns (string memory, string memory) {
        stringTest = _exampleString;
        internalTest(_intTest);
        return (stringTest, callTest); //return calldata input from this function and once translated to memory in internalTest()
    }
    
    //testing if calldata can be sent to internal functions, successful
    function internalTest(string calldata _internalCall) internal returns (string memory) {
        callTest = _internalCall;
    }
}
