// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//WORK IN PROGRESS -- USE AT OWN RISK
//SEE: https://cryptozombies.io/en/lesson/5/chapter/13
// @dev: create an ERC721 NFT for an aircraft, for purposes of the FAA Registry

contract AircraftToken is ERC721, Ownable {

  using SafeMath for uint;
  
  event CreateAircraft(
      address aircraftOwner, 
      string model, 
      string nNumber, 
      uint regId, 
      uint msn, 
      bool faaLienExists, 
      bool capeTownInterest, 
      bool fractionalOwner
      );

  struct Aircraft {
    address aircraftOwner;
    string model;
    string nNumber;
    uint regId;
    uint msn;
    bool faaLienExists;
    bool capeTownInterest; 
    bool fractionalOwner;
  }

  Aircraft[] public aircraft;
  
  //SEE: https://medium.com/openberry/erc721-vue-js-cryptokitties-like-dapp-in-under-10-minutes-5115efc9e0bb
  //Initializing an ERC-721 Token named 'AircraftToken' with a symbol 'AIR'
  constructor() ERC721("AircraftToken", "AIR") public {
  }

  // Fallback function
  receive() external payable {
  }

    function _createAircraft(
        address _aircraftOwner, 
        string memory _model, 
        string memory _nNumber, 
        uint _regId, 
        uint _msn, 
        bool _faaLienExists, 
        bool _capeTownInterest, 
        bool _fractionalOwner
        ) internal returns (uint) {
    // may change to onlyOwner, if intended for registry creation of NFT
    Aircraft memory newAircraft = Aircraft({
        aircraftOwner: _aircraftOwner,
        model: _model,
        nNumber: _nNumber,
        regId: _regId,
        msn: _msn,
        faaLienExists: _faaLienExists,
        capeTownInterest: _capeTownInterest,
        fractionalOwner: _fractionalOwner
    });
    // aircraft.push(Aircraft(_aircraftOwner, _model, _nNumber,  _regId, _msn, _faaLienExists, _capeTownInterest, _fractionalOwner));
    // need better way to create newAircraftId
    uint newAircraftId = _regId.add(1);
    super._mint(_aircraftOwner, newAircraftId);
    emit CreateAircraft(
        newAircraft.aircraftOwner, 
        newAircraft.model, 
        newAircraft.nNumber, 
        newAircraft.regId, 
        newAircraft.msn, 
        newAircraft.faaLienExists, 
        newAircraft.capeTownInterest, 
        newAircraft.fractionalOwner
        );
    return newAircraftId;
  }
  
  //****THIS NEEDS WORK - want to view Aircraft by regId, or maybe one of the other parameters
  function aircraftDetails(uint _regId) public view returns(address, string memory, string memory, uint, bool, bool, bool) {
    Aircraft storage regToken = aircraft[_regId];
    return (
        regToken.aircraftOwner, 
        regToken.model, 
        regToken.nNumber, 
        regToken.msn, 
        regToken.faaLienExists, 
        regToken.capeTownInterest, 
        regToken.fractionalOwner
        );
  }
  
  // @dev Function to buy a new airraft token (calls createAircraft() with given parameters)
  function buyRegToken(
        address _aircraftOwner, 
        string calldata _model, 
        string calldata _nNumber, 
        uint _regId, 
        uint _msn, 
        bool _faaLienExists, 
        bool _capeTownInterest, 
        bool _fractionalOwner
        ) external payable returns(uint) {
    require(msg.value >= 0.02 ether);
    _createAircraft(_aircraftOwner, _model, _nNumber, _regId, _msn, _faaLienExists, _capeTownInterest, _fractionalOwner);
    }
}
