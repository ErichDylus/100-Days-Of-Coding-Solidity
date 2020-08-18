pragma solidity ^0.6.0;

//adapted from https://docs.chain.link/docs/existing-job-request#config 

import "https://github.com/smartcontractkit/chainlink/blob/develop/evm-contracts/src/v0.6/ChainlinkClient.sol";

contract USDConvert is ChainlinkClient {
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    uint256 public ethereumPrice;
    
    /**
     * Network: Ropsten
     * Oracle: 
     *      Name:           Omniscience Ropsten
     *      Listing URL:    https://market.link/nodes/57587577-8ded-4d56-bb89-14da301e71cb
     *      Address:        0x83dA1beEb89Ffaf56d0B7C50aFB0A66Fb4DF8cB1
     * Job: 
     *      Name:           ETH-USD CoinGecko
     *      Listing URL:    https://market.link/jobs/d630df4f-1ed1-449b-8c0b-c27ab7a581a2
     *      ID:             93547cb3c6784ec08a366be6211caa24
     *      Fee:            0.1 LINK
     */
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0x83dA1beEb89Ffaf56d0B7C50aFB0A66Fb4DF8cB1; // oracle address
        jobId = "93547cb3c6784ec08a366be6211caa24"; //job id
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }
    
    //make initial request
    function requestEthereumPrice() public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillEthereumPrice.selector);
        sendChainlinkRequestTo(oracle, req, fee);
    }
    
    //callback function
    function fulfillEthereumPrice(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId) {
        ethereumPrice = _price;
    }
}
