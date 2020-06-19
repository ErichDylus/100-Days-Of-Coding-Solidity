pragma solidity ^0.6.0;

import "./CreateAircraft.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

/* WORK IN PROGRESS -- USE AT OWN RISK
 * @dev including OpenZeppelin's implementation of ERC721 */

contract AircraftOwnership is CreateAircraft, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) aircraftApprovals;

  modifier onlyOwnerOf(uint _aircraftId) {
    require(msg.sender == aircraftToOwner[_aircraftId]);
    _;
  }
  
  /*** for future AircraftInterface implementation, allow owner to change address of CreateAircraft if necessary
  function setCreateAircraftAddress(address _address) external onlyOwner {
    createAircraft = AircraftInterface(_address);
  } ***/
  
  function balanceOf(address _owner) external view returns (uint256) {
    return ownerAircraftCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return aircraftToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerAircraftCount[_to] = ownerAircraftCount[_to].add(1);
    ownerAircraftCount[msg.sender] = ownerAircraftCount[msg.sender].sub(1);
    aircraftToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (aircraftToOwner[_tokenId] == msg.sender || aircraftApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  //only owner may approve transfer of token
  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    aircraftApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

}
