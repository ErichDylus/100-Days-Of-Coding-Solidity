pragma solidity 0.5.11;

contract Test {

    string stringTest;

    function memoryTest(string memory _exampleString) public returns (string memory) {
        stringTest = _exampleString;  // You can modify memory
        string memory newString = stringTest;  // You can use memory within a function's logic
        return newString;  // You can return memory
    }

    function calldataTest(string calldata _exampleString) external returns (string memory) {
        stringTest = _exampleString;
        return stringTest;
    }
}
