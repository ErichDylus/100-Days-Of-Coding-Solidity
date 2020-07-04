pragma solidity ^0.6.0;

contract Lottery {

  address public manager;
  
  function Lottery() public {
    manager = msg.sender;
  }
  
  function enter() {

  }
  
  function pickWinner() {

  }
}
