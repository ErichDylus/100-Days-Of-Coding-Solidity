// SPDX-License-Identifier: MIT
// FOR DEMONSTRATION ONLY, unaudited, not recommended to be used for any purpose, carries absolutely no warranty of any kind
// @dev ERC20 holder-gated access to an IPFS link 

pragma solidity ^0.8.6;

interface ERC20 { //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/ERC20.sol
    function balanceOf(address account) external view returns (uint256); 
}

contract AccessByERC20 {

    address token;
    address owner;
    string public IPFSlink;
    ERC20 public erc20;
    mapping(address => uint256) tokenBalance;
    
    event LinkChanged();
    
    // deployer sets token address and IPFS link
    constructor(address _token, string memory _IPFSlink) { 
        token = _token;
        IPFSlink = _IPFSlink;
        erc20 = ERC20(token);
        owner = msg.sender;
    }
    
    function setIPFSLink(string memory _IPFSlink) external {
        require(msg.sender == owner, "Not authorized to change IPFS link.");
        IPFSlink = _IPFSlink;
        emit LinkChanged();
    }
    
    //check msg.sender ERC20 balance and assign mapping in order to accessLink()
    function checkBalance() external {
        uint256 _balance = _setBalance(msg.sender);
        tokenBalance[msg.sender] = _balance;
    }
    
    function _setBalance(address _caller) internal view returns(uint256) {
        return(erc20.balanceOf(_caller));
    }
    
    function accessLink() external view returns(string memory) {
        if (tokenBalance[msg.sender] > 0) {
            return(IPFSlink);
        } else {
            return("Only tokenholders may access the link.");
        }
    } 
}
