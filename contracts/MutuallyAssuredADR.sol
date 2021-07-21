// SPDX-License-Identifier: MIT
// IN PROCESS, incomplete
// FOR DEMONSTRATION ONLY, unaudited, not recommended to be used for any purpose, carries absolutely no warranty of any kind
// Option for dispute resolution via LexDAO's LexLocker - if declined for offchain dispute resolution, guildKick everyone, RIP

pragma solidity 0.5.3;

import "https://github.com/MolochVentures/moloch/blob/master/contracts/Moloch.sol";

interface LexLocker {
    function requestLockerResolution(address counterparty, address resolver, address token, uint256 sum, string calldata details, bool swiftResolver) external payable returns (uint256);
}

contract MutuallyAssuredADR is Moloch {
    
    bool onChain;
    address lexlocker = 0xD476595aa1737F5FdBfE9C8FEa17737679D9f89a; //LexLocker ETH mainnet contract address
    address lexDAO = 0x01B92E2C0D06325089c6Fd53C98a214f5C75B2aC; //lexDAO ETH mainnet address, used below as resolver 
    
    event isDisputed(Member, bool onChain);
    
    constructor() public {}
    
    function dispute(string memory _details, bool _onChain) public onlyMember returns(string memory){
        address _initiator = msg.sender;
        if (_onChain) {
            LexLocker(lexlocker).requestLockerResolution(_initiator, lexDAO, 0, 0, _details, false);
            //lexlocker.transfer(escrowAddress.balance);
            isDisputed = true;
            onChain = true;
            emit isDisputed(_initiator, onChain);
            return("LexLocker dispute resolution initiated.");
        } else if (!_onChain) {
            LexLocker(lexlocker).requestLockerResolution(_initiator, lexDAO, 0, 0, _details, false);
            ///lexlocker.transfer(escrowAddress.balance); //  presumably balance only holds the deposit amount if buyer is initiating dispute
            isDisputed = true;
            onChain = false;
            emit isDisputed_initiator, onChain);
            return("Moloch slain, press F to pay respects.");
        }
  }
}
