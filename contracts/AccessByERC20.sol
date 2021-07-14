// SPDX-License-Identifier: MIT
// ******** IN PROCESS ********

pragma solidity ^0.8.6;

//FOR DEMONSTRATION ONLY, not recommended to be used for any purpose, carries absolutely no warranty of any kind
//currenty testing on Rinkeby
//@dev create ERC20 holder-gated access to an IPFS link 

interface ERC20 { //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/ERC20.sol
    function balanceOf(address account) external view returns (uint256); 
}

contract AccessByERC20 {

    address token;
    address owner;
    string public IPFSlink;
    ERC20 public erc20;
    mapping(address => uint256) tokenBalance;
    
    //event LinkViewed(address indexed viewer);
    
    constructor(address _token, string memory _IPFSlink) public { 
        _token = token;
        _IPFSlink = IPFSlink;
        erc20 = ERC20(token);
        owner = msg.sender;
    }
    
    function setIPFSLink(string calldata _IPFSlink) external {
        require(msg.sender == owner, "Not authorized to change IPFS link.");
        _IPFSlink = IPFSlink;
    }
    
    //check msg.sender ERC20 balance and assign mapping in order to accessLink()
    function setBalance() external {
        uint256 _balance = checkBalance(msg.sender);
        _balance = tokenBalance[msg.sender];
    }
    
    function checkBalance(address _caller) internal view returns(uint256) {
        return(erc20.balanceOf(_caller));
    }
    
    function accessLink() external returns(string memory) {
        if (tokenBalance[msg.sender] > 0) {
            return(IPFSlink);
            //emit LinkViewed(msg.sender);
        } else {
            return("Only tokenholders may access the link.");
        }
    } 
}
