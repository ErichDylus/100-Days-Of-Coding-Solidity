// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// **********WORK IN PROGRESS -- USE AT OWN RISK**********
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
  uint i = 0;
  
  // @dev Initializing an ERC-721 standard token named 'AircraftToken' with a symbol 'AIR'
  constructor() ERC721("AircraftToken", "AIR") public {
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
        bool _faaLienExists, 
        bool _capeTownInterest, 
        bool _fractionalOwner
        ) internal returns (uint, uint) {
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
    
    // create unique aircraft identifier based on owner reg ID, i number and msn, but may not be necessary for tokenID
    uint newAircraftId = uint(keccak256(abi.encodePacked(_regId + i + _msn)));
    aircraft.push(Aircraft(_aircraftOwner, _model, _nNumber,  _regId, _msn, _faaLienExists, _capeTownInterest, _fractionalOwner));
    i++;
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
    return(newAircraftId, i);
  }
  
  // return aircraft details based on i number (must be inputted by searcher, for now)
  function aircraftDetails(uint _i) public view returns(address, string memory, string memory, uint, bool, bool, bool) {
    Aircraft storage regToken = aircraft[_i];
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
        string calldata _model, 
        string calldata _nNumber, 
        uint _regId, 
        uint _msn, 
        bool _faaLienExists, 
        bool _capeTownInterest, 
        bool _fractionalOwner
        ) external payable returns(uint) {
    require(msg.value >= 0.02 ether);
    _createAircraft(msg.sender, _model, _nNumber, _regId, _msn, _faaLienExists, _capeTownInterest, _fractionalOwner);
    }
    
    //SEE: https://medium.com/openberry/erc721-vue-js-cryptokitties-like-dapp-in-under-10-minutes-5115efc9e0bb
    // newAircraftId must be non-replicable SEE https://ethereum.stackexchange.com/questions/9965/how-to-generate-a-unique-identifier-in-solidity
    /*** may look into Uniform Resource Identifiers (URI) 
    **** function tokenURI(uint256 _tokenId) external view returns (string);
    *** RFC 3986 ERC721 Metadata JSON Schema **/
}
