//SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

/*unaudited and not for mainnet use of any kind, provided without any warranty whatsoever
**IN PROCESS; NEED TO CODE WINNERS' PAYOUTS
**@dev create a simple smart ETH escrow contract for a fantasy football league, 17 week season, with contributions and payout in ETH
**intended to be deployed by commissioner, who is an identified party, after draft is concluded
**single league, single year*/

contract FantasyFootball {

  address[] public teams; 
  address escrowAddress = address(this);
  address payable firstPlace;
  address payable secondPlace;
  address payable thirdPlace;
  address payable commissioner;
  uint8 week;
  uint256 deposit;
  bool isOver;
  string description;
  mapping(address => bool) public teamWhitelist; //for commissioner to whitelist addresses that may enter league
  mapping(address => bool) public isTeam; //map whether an address is a team in the league
  mapping(address => uint256) public points; //map total points per team for standings
  
  event LeagueDetails(string description, uint256 deposit);
  event PayFirstPlace();
  event PaySecondPlace();
  event PayThirdPlace();
  event SeasonOver(bool isOver);
  
  modifier onlyCommissioner() { 
    require(msg.sender == commissioner, "This may only be called by the league's commissioner");
    _;
  }
  
  //commissioner deploys contract with description, its deposit amount, and seconds until season expiry
  constructor(string memory _description, uint256 _deposit) payable {
      require(msg.value >= deposit, "Submit deposit amount");
      commissioner = payable(address(msg.sender));
      deposit = _deposit;
      description = _description;
      isTeam[commissioner] = true;
      emit LeagueDetails(description, deposit);
  }
  
  //commissioner whitelists addresses who may enter league as a team (who participated in the draft)
  function whitelistTeam(address payable _team) public onlyCommissioner {
      require(!teamWhitelist[_team], "Party already a team");
      require(!isOver, "Season over, too late");
      teamWhitelist[_team] = true;
  }
  
  //team pays deposit and enters league if previously whitelisted by commissioner and not already a team
  function enterLeague(address payable _teamAddress) public payable {
      require(!isTeam[_teamAddress], "Address is already a team");
      require(teamWhitelist[_teamAddress], "Address has not been whitelisted by commissioner");
      require(!isOver, "Season over, too late");
      require(msg.value >= deposit, "Submit deposit amount");
      isTeam[_teamAddress] = true;
      teams.push(_teamAddress);
  }
  
  //TODO: weekly increment of points and season week by commissioner, publicly verifiable
  //leaderboard function checking points of each team in array
  
  function weeklyPoints() public onlyCommissioner {
      require(week < 17, "Season over.");
      week++;
  }
    
  // check if expired and payout winners if so
  function endSeason() public onlyCommissioner returns(bool) {
      require(week > 16, "Season still in process.");
      isOver = true;
      //iterate through teams[] to assign places
      //firstPlace.transfer(escrowAddress.balance);
      //emit PayFirstPlace();
      emit SeasonOver(isOver);
      return(isOver);
  }
}
