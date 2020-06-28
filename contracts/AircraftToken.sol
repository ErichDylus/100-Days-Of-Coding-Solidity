// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//WORK IN PROGRESS -- USE AT OWN RISK
//SEE: https://cryptozombies.io/en/lesson/5/chapter/13
// @dev: create an ERC721 NFT for an aircraft, for purposes of the FAA Registry

contract AircraftToken is ERC721, Ownable {

  using SafeMath for uint;
  
  event NewAircraft(address aircraftOwner, string model, string nNumber, uint regId, uint msn, bool faaLienExists, bool capeTownInterest, bool fractionalOwner);

  struct Aircraft {
    string model;
    string nNumber;
    uint msn;
    bool faaLienExists;
    bool capeTownInterest; 
    bool fractionalOwner;
  }

  Aircraft[] public aircraft;
  uint regId;
  
  //SEE: https://medium.com/openberry/erc721-vue-js-cryptokitties-like-dapp-in-under-10-minutes-5115efc9e0bb
  //Initializing an ERC-721 Token named 'AircraftToken' with a symbol 'AIR'
  constructor() ERC721("AircraftToken", "AIR") public {
  }

  // Fallback function
  fallback() external payable {
  }

  mapping (uint => address) public aircraftToOwner;
  mapping (address => uint) ownerAircraftCount;

  function _createAircraft(address aircraftOwner, string memory _model, string memory _nNumber, uint _regId, uint _msn, bool _faaLienExists, bool _capeTownInterest, bool _fractionalOwner) public payable {
    require(aircraftOwner == msg.sender);
    require(msg.value >= 0.02 ether);
    regId = _regId;
    Aircraft storage regToken = aircraft[regId];
    aircraft.push(Aircraft(_model, _nNumber,  _msn, _faaLienExists, _capeTownInterest, _fractionalOwner));
    aircraftToOwner[regId] = msg.sender;
    ownerAircraftCount[msg.sender] = ownerAircraftCount[msg.sender].add(1);
    emit NewAircraft(aircraftOwner, _model, _nNumber, regId, _msn, _faaLienExists, _capeTownInterest, _fractionalOwner);
  }
  
  //****THIS NEEDS WORK
  function aircraftDetails() public view returns(string memory, string memory, uint, bool, bool, bool) {
    return (regToken.aircraftOwner, regToken.model, regToken.nNumber, regToken.msn, regToken.faaLienExists, regToken.capeTownInterest, regToken.fractionalOwner);
  }
  
  // @dev Function to allow user to buy a new airraft token (calls createAircraft())
  //function buyRegToken() external payable {
    //require(msg.value == 0.02 ether);
    //createAircraft();
    //}
}
