pragma solidity >=0.4.0 <0.6.0;

contract Vote {
  // constructor to initialize two candidates
  // vote for candidates
  // get count of votes for each candidate
  
  bytes32[2] public candidateList;
  string candidateOneName;
  string candidateTwoName;
  mapping (bytes32 => uint8) public votesReceived;

  constructor(string memory _candidateOne, string memory _candidateTwo) public {
    bytes32 candidateOne = keccak256(abi.encodePacked(_candidateOne));
    bytes32 candidateTwo = keccak256(abi.encodePacked(_candidateTwo));
    candidateList = [candidateOne,candidateTwo];
    candidateOneName = _candidateOne;
    candidateTwoName = _candidateTwo;
  }
  
  //vote for candidate, currently unlimited number of votes
  function voteForCandidate(bytes32 candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }
  
  //return total votes for candidate
  function totalVotesFor(bytes32 candidate) view public returns(uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }
  
  //check if candidate is valid
  function validCandidate(bytes32 candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
  
  //return names of candidates
  function checkNames() view public returns(string memory, string memory){
      return (candidateOneName, candidateTwoName);
  }
  
}
