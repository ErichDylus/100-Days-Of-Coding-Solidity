//SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

/*unaudited and not for mainnet use of any kind, provided without any warranty whatsoever
**IN PROCESS, INCOMPLETE
**@dev create a simple smart ETH escrow contract for a fantasy football league, 17 week season, with contributions and payout in ETH
**intended to be deployed by commissioner, who is an identified party, after draft is concluded
**single league, single year*/

contract FantasyFootball {
  address[] public teams; 
  address payable commissioner;
  uint8 week;
  uint256 deposit;
  bool isOver;
  string description;
  mapping(address => bool) public teamWhitelist; //for commissioner to whitelist addresses that may enter league
  mapping(address => bool) public isTeam; //map whether an address is a team in the league
  mapping(address => uint256) public points; //map total points per team for standings
  mapping(address => uint256) public teamWeek;
  
  struct TeamWeek {
    address team;
    uint256 week;
    bool pointsEntered;
  }

  TeamWeek[] public teamweeks;
  
  event LeagueDetails(string description, uint256 deposit, address commissioner);
  event PointsEntered(address indexed team, uint256 week, uint256 points);
  event PayFirstPlace(address firstPlace);
  event PaySecondPlace(address secondPlace);
  event PayThirdPlace(address thirdPlace);
  event SeasonOver(bool isOver);
  
  modifier onlyCommissioner() { 
    require(msg.sender == commissioner, "This may only be called by the league's commissioner");
    _;
  }
  
  //commissioner deploys contract with league description and required deposit amount (along with commissioner's deposit)
  // @param _description: brief league description/identifier 
  // @param _deposit: amount of wei required to partipate in league (ETH / 1e18)
  constructor(string memory _description, uint256 _deposit) payable {
      require(msg.value >= _deposit, "Submit deposit amount");
      commissioner = payable(address(msg.sender));
      deposit = _deposit;
      description = _description;
      isTeam[commissioner] = true;
      emit LeagueDetails(description, deposit, commissioner);
  }
  
  //commissioner whitelists addresses who may enter league as a team (who participated in the draft)
  // @param _team: address of participant in draft, who will subsequently call enterLeague() with deposit 
  function whitelistTeam(address payable _team) public onlyCommissioner returns(bool){
      require(!teamWhitelist[_team], "Party already a team");
      require(!isOver, "Season over, too late");
      teamWhitelist[_team] = true;
      return(true);
  }
  
  //team pays deposit and enters league if previously whitelisted by commissioner and not already a team
  function enterLeague() public payable returns (bool){
      require(!isTeam[msg.sender], "Address is already a team");
      require(teamWhitelist[msg.sender], "Address has not been whitelisted by commissioner");
      require(!isOver, "Season over, too late");
      require(msg.value >= deposit, "Submit deposit amount");
      isTeam[msg.sender] = true;
      teams.push(msg.sender);
      return(true);
  }
  
  //weekly increment of points by commissioner, publicly verifiable, one team at a time 
  // @param _teamAddress: address of team which is confirmed in league and has paid deposit
  // @param _points: _teamAddress's weekly point total to add to their tally
  function weeklyPoints(address _teamAddress, uint256 _points) public onlyCommissioner {
      require(week < 17, "Season over.");
      points[_teamAddress] += _points;
      teamweeks.push(TeamWeek(_teamAddress, week, true)); //TODO: Check this teamweeks hasn't been pushed yet without an array of structs lookup
      emit PointsEntered(_teamAddress, week, _points);
  }
  
  // for commissioner to increment the season week after entering weeklyPoints for each _teamAddress
  function incrementWeek() public onlyCommissioner returns(uint256){
      require(week < 17, "Season over.");
      week++;
      return(week);
  }

  //check point total of a team 
  function checkPointTotal(address _teamAddress) public view returns(uint256) {
      return(points[_teamAddress]);
  }
    
  //commissioner calls checkPointTotal for each address and passes the top three to this function
  //third place receives their deposit back, second place gets double the deposit amount, first place gets everything else
  // @param __firstPlace, _secondPlace, _thirdPlace: 1st, 2nd, 3rd place winners verifiable by checkPointTotal
  function endSeason(address payable _firstPlace, address payable _secondPlace, address payable _thirdPlace) public onlyCommissioner returns(bool) {
      require(week > 16, "Season still in process.");
      require(isTeam[_firstPlace] && isTeam[_secondPlace] && isTeam[_thirdPlace], "Re-enter addresses");
      isOver = true;
      _thirdPlace.transfer(deposit);
      emit PayThirdPlace(_thirdPlace);
      _secondPlace.transfer(deposit * 2);
      emit PaySecondPlace(_secondPlace);
      _firstPlace.transfer(address(this).balance);
      emit PayFirstPlace(_firstPlace);
      emit SeasonOver(isOver);
      return(isOver);
  }
}
