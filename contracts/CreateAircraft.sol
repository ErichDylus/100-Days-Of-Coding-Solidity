pragma solidity ^0.6.0

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

//WORK IN PROGRESS -- USE AT OWN RISK
//see https://cryptozombies.io/en/lesson/5/chapter/13

contract CreateAircraft is Ownable {

  using SafeMath32 for uint32;
  
  event NewAircraft(uint aircraftId, string model, string nNumber, uint msn, uint regId);

  struct Aircraft {
    string model;
    string nNumber;
    uint32 msn;
    uint regId;
    bool faaLienExists;
    bool capeTownInterest, 
    bool fractionalOwner;
  }

  Aircraft[] public aircraft;

  mapping (uint => address) public aircraftToOwner;
  mapping (address => uint) ownerAircraftCount;

  function _createAircraft(string memory _model, string memory _nNumber, uint32 _msn, uint _regId) internal {
    uint id = aircraft.push(Aircraft(_model, _nNumber,  _msn, _regId) - 1;
    aircraftToOwner[id] = msg.sender;
    ownerAircraftCount[msg.sender] = ownerAircraftCount[msg.sender].add(1);
    emit NewAircraft(id, _model, _nNumber, _msn, _regId);
  }

}
