//SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

/*unaudited and not for mainnet use of any kind, provided without any warranty whatsoever
**IN PROCESS; NEED TO CODE WINNERS' PAYOUTS
**@dev create a simple smart escrow contract for a fantasy football league, with contributions and payout in ETH
**intended to be deployed by commissioner, who is an identified party*/

contract FantasyFootball {
    
  //escrow struct to contain basic description of underlying deal, purchase price, ultimate recipient of funds
  struct LeagueDetails {
      string description;
      uint256 deposit;
  }
  
  LeagueDetails[] public leagues;
  address escrowAddress = address(this);
  address payable firstPlace;
  address payable secondPlace;
  address payable thirdPlace;
  address payable commissioner;
  uint256 deposit;
  uint256 effectiveTime;
  uint256 expirationTime;
  bool isOver;
  bool isExpired;
  string description;
  mapping(address => bool) public teamWhitelist; //for commissioner to whitelist addresses that may enter league
  mapping(address => bool) public teams; //map whether an address is a team in the league
  
  event Expired(bool isExpired);
  event SeasonOver(bool isOver);
  
  modifier restricted() { 
    require(msg.sender == commissioner, "This may only be called by the league's commissioner");
    _;
  }
  
  //commissioner deploys contract with description, its deposit amount, and seconds until season expiry
  constructor(string memory _description, uint256 _deposit, uint256 _secsUntilExpiration) payable {
      require(msg.value >= deposit, "Submit deposit amount");
      commissioner = payable(address(msg.sender));
      deposit = _deposit;
      description = _description;
      teams[commissioner] = true;
      effectiveTime = uint256(block.timestamp);
      expirationTime = effectiveTime + _secsUntilExpiration;
      newLeague(description, deposit);
  }
  
  //commissioner whitelists addresses who may enter league as a team
  function whitelistTeam(address payable _team) public restricted {
      require(!teamWhitelist[_team], "Party already a team");
      require(!isExpired, "Season expired, too late");
      teamWhitelist[_team] = true;
  }
  
  //team pays deposit and enters league if previously whitelisted by commissioner and not already a team
  function enterLeague(address payable _team) public payable {
      require(!teams[msg.sender], "Address is already a team");
      require(teamWhitelist[msg.sender], "Address has not been whitelisted by commissioner");
      require(!isExpired, "Season expired, too late");
      require(msg.value >= deposit, "Submit deposit amount");
      teams[_team] = true;
  }
  
  //create new escrow contract within master structure
  function newLeague(string memory _description, uint256 _deposit) private {
      LeagueDetails memory newRequest = LeagueDetails({
         description: _description,
         deposit: _deposit
      });
      leagues.push(newRequest);
  }
  
  //TODO: weekly increment of points by commissioner to top three addresses
    
  // check if expired and payout winners if so
  function endSeason() public restricted returns(bool) {
      if (expirationTime <= uint256(block.timestamp)) {
            isExpired = true;
            //buyer.transfer(escrowAddress.balance);
            emit Expired(isExpired);
        } else {
            isOver = true;
            //seller.transfer(escrowAddress.balance);
            emit SeasonOver(isOver);
        }
        return(isOver);
  }
}
