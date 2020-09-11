pragma solidity >=0.4.0 <0.6.0;

contract Vote {
  // constructor to initialize two candidates
  // vote for candidates
  // get count of votes for each candidate
  
  bytes32[2] public candidateList;
  mapping (bytes32 => uint8) public votesReceived;

  constructor(bytes32 _candidateOne, bytes32 _candidateTwo) public {
    candidateList = [_candidateOne,_candidateTwo];
    //candidateList = _candidateNames;
  }
  
  function voteForCandidate(bytes32 candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }
  
  function totalVotesFor(bytes32 candidate) view public returns(uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }
  
  function validCandidate(bytes32 candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
  
}
