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

/*
// SPDX-License-Identifier: MIT
// FOR DEMONSTRATION ONLY, unaudited, not recommended to be used for any purpose, carries absolutely no warranty of any kind
// @dev ERC20 holder-gated assent to a Token Delegation and Voting Policy, with reference to their own Delegation Disclosure
// TESTING ON RINKEBY

pragma solidity ^0.8.6;

interface ERC20 { //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/ERC20.sol
    function balanceOf(address account) external view returns (uint256); 
}

// Delegator deploys and signs their Token Delegation and Voting Policy and signs
// for example, (rinkeby: https://rinkeby.etherscan.io/address/0x2d60f4bef0b212018bf936515a90946d54eb08d8#code)
// this interface allows a delegate to indicate their assent by EthSign

interface VoteDelegateDisclosure {
    function sign(string calldata details) external; 
}

contract SignDelegationPolicy {

    address token;
    address owner;
    string public IPFSlink;
    ERC20 public erc20;
    VoteDelegateDisclosure public policyContract;
    mapping(address => uint256) tokenBalance;
    mapping(address => string) disclosureHash;
    
    event DelegateDisclosure(address indexed delegate, string signature, string IPFSlink);
    
    // deployer sets token address and address of Token Delegation and Voting Policy (https://github.com/LeXpunK-Army/Token-Delegation-And-Voting-Policy)
    constructor(address _token, address _policyContract) { 
        token = _token;
        policyContract = VoteDelegateDisclosure(_policyContract);
        erc20 = ERC20(token);
        owner = msg.sender;
    }
    
    
    function signPolicy(string memory _IPFSlink, string calldata _signature) external {
        require(tokenBalance[msg.sender] > 0, "Signatory not a token holder.");
        disclosureHash[msg.sender] = _IPFSlink;
        policyContract.sign(_signature);
        emit DelegateDisclosure(msg.sender, _signature, _IPFSlink);
    }
    
    //check msg.sender ERC20 balance and assign mapping in order to accessLink()
    function checkBalance() external {
        uint256 _balance = _setBalance(msg.sender);
        tokenBalance[msg.sender] = _balance;
    }
    
    function _setBalance(address _caller) internal view returns(uint256) {
        return(erc20.balanceOf(_caller));
    }
}
*/
