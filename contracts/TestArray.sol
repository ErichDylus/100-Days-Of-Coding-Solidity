pragma solidity ^0.6.0;

contract Test {
  uint[] public myArray;
  
  function initalize() public {
    myArray.push(1);
    myArray.push(10);
    myArray.push(30);
  }
  
  function getMyArray() public view returns (uint[] memory){
      return myArray;
  }
  
  function getArrayLength() public view returns (uint) {
    return myArray.length;
  }
  
  function getFirstElement() public view returns (uint) {
    return myArray[0];
  }
}
