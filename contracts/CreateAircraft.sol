// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

//WORK IN PROGRESS -- USE AT OWN RISK
//see https://cryptozombies.io/en/lesson/5/chapter/13

contract CreateAircraft is Ownable {

  using SafeMath for uint;
  
  event NewAircraft(string model, string nNumber, uint msn, uint regId, bool faaLienExists, bool capeTownInterest, bool fractionalOwner);

  struct Aircraft {
    string model;
    string nNumber;
    uint msn;
    uint regId;
    bool faaLienExists;
    bool capeTownInterest; 
    bool fractionalOwner;
  }

  Aircraft[] public aircraft;

  mapping (uint => address) public aircraftToOwner;
  mapping (address => uint) ownerAircraftCount;

  function _createAircraft(string memory _model, string memory _nNumber, uint _msn, uint _regId, bool _faaLienExists, bool _capeTownInterest, bool _fractionalOwner) internal {
    aircraft.push(Aircraft(_model, _nNumber,  _msn, _regId,  _faaLienExists, _capeTownInterest, _fractionalOwner));
    aircraftToOwner[_regId] = msg.sender;
    ownerAircraftCount[msg.sender] = ownerAircraftCount[msg.sender].add(1);
    emit NewAircraft(_model, _nNumber, _msn, _regId, _faaLienExists, _capeTownInterest, _fractionalOwner);
  }
  
  //****THIS NEEDS WORK
  function aircraftDetails() public view returns(string memory, string memory, uint, uint, bool, bool, bool) {
        return (aircraft.model, aircraft.nNumber, aircraft.msn, aircraft.regId, aircraft.faaLienExists, aircraft.capeTownInterest, aircraft.fractionalOwner);
  }
}
