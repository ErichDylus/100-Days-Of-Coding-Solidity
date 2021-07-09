//SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

/*unaudited and not for mainnet use of any kind, provided without any warranty whatsoever
**IN PROCESS; NEED TO CODE WINNERS' PAYOUTS
**@dev create a simple smart escrow contract for a fantasy football league, with contributions and payout in ETH
**intended to be deployed by commissioner, who is an identified party, after draft is concluded
**single league, single year*/

contract FantasyFootball {
    
  //struct with league name/details and per-team deposit amount
  struct LeagueDetails {
      string description;
      uint256 deposit;
  }

  address escrowAddress = address(this);
  address payable firstPlace;
  address payable secondPlace;
  address payable thirdPlace;
  address payable commissioner;
  uint256 deposit;
  uint256 effectiveTime;
  uint256 expirationTime;
  bool isOver;
  string description;
  mapping(address => bool) public teamWhitelist; //for commissioner to whitelist addresses that may enter league
  mapping(address => bool) public teams; //map whether an address is a team in the league
  mapping(address => uint256) public points; //map total points per team for standings
  
  event PayFirstPlace();
  event PaySecondPlace();
  event PayThirdPlace();
  event SeasonOver(bool isOver);
  
  modifier restricted() { 
    require(msg.sender == commissioner, "This may only be called by the league's commissioner");
    _;
  }
  
  //commissioner deploys contract with description, its deposit amount, and seconds until season expiry
  constructor(string memory _description, uint256 _deposit, uint256 _secsUntilSeasonOver) payable {
      require(msg.value >= deposit, "Submit deposit amount");
      commissioner = payable(address(msg.sender));
      deposit = _deposit;
      description = _description;
      teams[commissioner] = true;
      effectiveTime = uint256(block.timestamp);
      expirationTime = effectiveTime + _secsUntilSeasonOver;
      LeagueDetails(description, deposit);
  }
  
  //commissioner whitelists addresses who may enter league as a team (who participated in the draft)
  function whitelistTeam(address payable _team) public restricted {
      require(!teamWhitelist[_team], "Party already a team");
      require(!isOver, "Season over, too late");
      teamWhitelist[_team] = true;
  }
  
  //team pays deposit and enters league if previously whitelisted by commissioner and not already a team
  function enterLeague(address payable _teamAddress) public payable {
      require(!teams[_teamAddress], "Address is already a team");
      require(teamWhitelist[_teamAddress], "Address has not been whitelisted by commissioner");
      require(!isOver, "Season over, too late");
      require(msg.value >= deposit, "Submit deposit amount");
      teams[_teamAddress] = true;
  }
  
  //TODO: weekly increment of points by commissioner, publicly verifiable
    
  // check if expired and payout winners if so
  function endSeason() public restricted returns(bool) {
      require(expirationTime <= uint256(block.timestamp), "Season still in process.");
      isOver = true;
      //firstPlace.transfer(escrowAddress.balance);
      //emit PayFirstPlace();
      emit SeasonOver(isOver);
      return(isOver);
  }
}
