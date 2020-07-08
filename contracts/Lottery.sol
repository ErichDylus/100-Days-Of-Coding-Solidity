pragma solidity ^0.6.0;

contract Lottery {

  address public manager;
  address[] public players;
  
  constructor() public {
      manager = msg.sender;
  }
  
  function enterLottery() public payable {
    require(msg.value > .01 ether);
    players.push(msg.sender);
  }
  
  function pickWinner() public {

  }
}
