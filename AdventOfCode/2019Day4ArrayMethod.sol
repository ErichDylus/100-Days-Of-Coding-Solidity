// SPDX-License-Identifier: MIT

//in process

pragma solidity 0.7.0;

contract DayFour2019 {
  uint256[] pwordOptions;
  uint256[6] digitOptions;
  uint256 constant MIN = 123257;
  uint256 constant MAX = 647015;
  mapping (uint256 => bool) pass;
  
  constructor() {}
  
  //test each digit of six-number array
  function digits(uint256 _numCheck) private {
    require(digitOptions[0] >= 1 && digitOptions[0] <= 6);
    require(digitOptions[0] == digitOptions[1] | digitOptions[1] == digitOptions[2] | digitOptions[2] == digitOptions[3] | digitOptions[3] == digitOptions[4] | digitOptions[4] == digitOptions[5]);
    pass[_numCheck] = true;
  }
  
  //concatenate six-digit number
  function createNum() public {
      for(uint256 x = 0; x < 9; x++) {
       digits(x);   
      }
  }
  
  //test each full six-digit number
  function test(uint256 num) public {
      require(pwordOptions[] > MIN);
      require(pwordOptions[] < MAX);
  }
}
