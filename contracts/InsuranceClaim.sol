//SPDX-License-Identifier: MIT
//for testing purposes only, not audited nor suitable for any other use
//request resolution of API3 insurance claim through LexLocker (https://github.com/lexDAO/LexCorpus/blob/master/contracts/escrow/lexlocker/solidity/LexLocker.sol)

pragma solidity >=0.7.5;   

import "https://github.com/lexDAO/LexCorpus/blob/master/contracts/escrow/lexlocker/solidity/LexLocker.sol";
    
contract InsuranceClaim is LexLocker {
    
    address token = 0x0b38210ea11411557c13457d4da7dc6ea731b88a; //API3 token address
    address api3DAOaddress = 0x9B64177757a0BD2A042446C8d910526476B7Bf57; //API3DAO address, to be updated to v2
    address lexlocker = 0xD476595aa1737F5FdBfE9C8FEa17737679D9f89a;
    
    //initiated by claimant (client for purposes of LexLocker), counterparty is API3 DAO, resolver (API3 Insurance KLeros court or simply LexDAO), claim amount, details of claim, swiftResolver false to prevent nuisance claims
    constructor(address _resolver, uint256 _claimAmount, string calldata _details) public {
        client = msg.sender;
        _resolver = resolver; //may hardcode the Kleros court for API3 insurance when live
        swiftResolver = false;
        counterparty = api3DAOaddress;
        sum = _claimAmount;
    }
    
    /* function lexLockerContract() public {
         lexlocker = LexLocker(0xD476595aa1737F5FdBfE9C8FEa17737679D9f89a);
     } */
    
    function requestResolution() public NonReentrant returns(uint256) {
    //Lump sump up for resolution by an arbitration address ( = resolver); $API3 deposit locked immediately for judgment.
    lexLocker.requestLockerResolution(counterparty, resolver, token, sum, details, swiftResolver);
    
    //OR 
    bytes memory payload = abi.encodeWithSignature("LexLocker(address, address, address, uint256, string calldata, bool)", counterparty, resolver, token, sum, details, swiftResolver);
    (bool success, bytes memory returnData) = address(lexlocker).call(payload);
    require(success);
    
    return(registration);
    }
}
