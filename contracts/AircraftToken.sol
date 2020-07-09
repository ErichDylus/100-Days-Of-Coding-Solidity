// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// **********WORK IN PROGRESS -- USE AT OWN RISK**********
// @dev: create an ERC721 standard NFT for an N-registered aircraft, for purposes of the FAA Registry
// owner would theoretically be the FAA, who could mint NFTs for each new registration and burn upon deregistration/N-number change/owner change, etc.

contract AircraftToken is ERC721, Ownable {

  using SafeMath for uint;
  
  event CreateAircraft(
      address aircraftOwner, 
      string model, 
      string nNumber, 
      uint regId, 
      uint msn, 
      bool lienExists, 
      bool fractionalOwner
      );

  struct Aircraft {
    address aircraftOwner;
    string model;
    string nNumber;
    uint regId;
    uint msn;
    bool lienExists; 
    bool fractionalOwner;
  }

  Aircraft[] public aircraft;
  uint i = 0;
  
  // @dev Initializing an ERC-721 standard token named 'NRegAircraftToken' with a symbol 'FAA'
  constructor() ERC721("NRegAircraftToken", "FAA") public {
  }

  // fallback function
  receive() external payable {
  }

    function _createAircraft(
        address _aircraftOwner, 
        string memory _model, 
        string memory _nNumber, 
        uint _regId, 
        uint _msn, 
        bool _lienExists, 
        bool _fractionalOwner
        ) internal returns (uint, uint) {
    
    Aircraft memory newAircraft = Aircraft({
        aircraftOwner: _aircraftOwner,
        model: _model,
        nNumber: _nNumber,
        regId: _regId,
        msn: _msn,
        lienExists: _lienExists,
        fractionalOwner: _fractionalOwner
    });
    
    // @dev create unique aircraft identifier based on owner reg ID, i number and msn
    uint newAircraftId = uint(keccak256(abi.encodePacked(_regId + i + _msn)));
    aircraft.push(Aircraft(_aircraftOwner, _model, _nNumber,  _regId, _msn, _lienExists, _fractionalOwner));
    i++;
    super._mint(_aircraftOwner, newAircraftId);
    emit CreateAircraft(
        newAircraft.aircraftOwner, 
        newAircraft.model, 
        newAircraft.nNumber, 
        newAircraft.regId, 
        newAircraft.msn, 
        newAircraft.lienExists, 
        newAircraft.fractionalOwner
        );
    return(newAircraftId, i);
  }
  
  // return aircraft details based on i number (must be inputted by searcher and remains viewable after corresponding token burned, for now)
  function aircraftDetails(uint _i) public view returns(address, string memory, string memory, uint, bool, bool) {
    Aircraft storage regToken = aircraft[_i];
    return (
        regToken.aircraftOwner, 
        regToken.model, 
        regToken.nNumber, 
        regToken.msn, 
        regToken.lienExists, 
        regToken.fractionalOwner
        );
  }
  
  // @dev buy a new FAA NFT for at least .02 ether (calls createAircraft() with given parameters)
  // NOTE: currently public for demonstration purposes, but could include onlyOwner to permit only the registry to create tokens, or require(whitelisted address)
  function buyRegToken(
        string calldata _model, 
        string calldata _nNumber, 
        uint _regId, 
        uint _msn, 
        bool _lienExists, 
        bool _fractionalOwner
        ) external payable returns(uint) {
    require(msg.value >= 0.02 ether);
    _createAircraft(msg.sender, _model, _nNumber, _regId, _msn, _lienExists, _fractionalOwner);
    }
    
    // @dev allow onlyOwner (presumably the Registry) to burn a registry token, for example if the aircraft is deregistered
    function burnToken(uint _tokenId) public onlyOwner {
        _burn(_tokenId);
    }
    
    //SEE: https://medium.com/openberry/erc721-vue-js-cryptokitties-like-dapp-in-under-10-minutes-5115efc9e0bb
    // newAircraftId must be non-replicable SEE https://ethereum.stackexchange.com/questions/9965/how-to-generate-a-unique-identifier-in-solidity
}
