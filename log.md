# 100 Days Of Code - Solidity - Log

### Day 45: July 27, Monday
**Today's Progress**: deployment considerations (creating factory within contract) and creating CampaignFactory.sol to mitigate security risks of creator tampering with Campaign.sol

**Thoughts**: more deprecations from Udemy course- typecasting address of the created campaign as follows: "address newCampaign = address(new Campaign(minimum, msg.sender));"

### Day 44: July 25, Saturday
**Today's Progress**: local memory structs and mappings to clean up code

**Thoughts**: cleaning up AdvanceRequirement and other arrays of structs will be a useful exercise

### Day 43: July 24, Friday
**Today's Progress**: Struct initialization and mappings in campaign.sol

### Day 42: July 23, Thursday
**Today's Progress**: coding spendingRequest, continue storage v. memory and mapping as gas saver

**Thoughts**: mappings as key-value pairs are similar to objects in javascript, constant time search is important

### Day 41: July 21, Tuesday
**Today's Progress**: storage v. memory considerations, structs continued, other campaign.sol edits

### Day 40: July 20, Monday
**Today's Progress**: mapping out "campaign" kickstarter contract, defining structs, note translations for escrow purpose

**Thoughts**: going forward, note methods for voting on funds release from escrow and constructed minimum escrow amount

### Day 39: July 18, Saturday
**Today's Progress**: reading through OpenZeppelin learn and OpenZeppelin CLI regarding upgradeable contracts

### Day 38: July 17, Friday
**Today's Progress**: NFT minting with cargo.build: https://alpha.cargo.build/dashboard/showcase/5f120c4073ca94140d75c084, migrating aircraft sale agreement from OpenLaw

**Thoughts**: very easy to mint NFTs with details, pictures, etc. Will need to test public visibility and whether another frontend can be used

### Day 37: July 15, Wednesday
**Today's Progress**: Ethereum app architecture and intro to React

**Thoughts**: React will bypass difficult javascript

### Day 36: July 14, Tuesday
**Today's Progress**: contract testing via javascript/git over my head and seemingly unnecessary for now-- will test manually for near future

### Day 35: July 13, Monday
**Today's Progress**: Udemy course and receiving/sending value, cleanup of AircraftToken, read RNG docs

**Thoughts**: Chainlink's VRF is a good goal implementation both for a random generator and generally as a first oracle implementation

### Day 34: July 10, Friday
**Today's Progress**: completed lottery contract with pickWinner, modifier, view array, transfer balance, and create new players array upon winner picked

**Thoughts**: the 'payable(players[index]).transfer(address(this).balance);' line of code is useful for emptying an escrow to the chosen address ('index') in array BUT apparently transfer is deprecated for call? will need to investigate

### Day 33: July 9, Thursday
**Today's Progress**: pseudo-random number generator for lottery contract, edits to AircraftToken, use pseudo-rand number modulus players array length to choose lottery winner

**Thoughts**: would be interesting to try and include chainlink's VRF here, will attempt later

### Day 32: July 8, Wednesday
**Today's Progress**: solidity array issues: nested arrays do not port over, etc., continuing lottery contract

**Thoughts**: important to realize strings are represented as dynamic arrays in solidity, so cannot transfer arrays of strings to javascript

### Day 31: July 7, Tuesday
**Today's Progress**: burn function and other tuneups to AircraftToken.sol, Udemy course lessons on data structures

**Thoughts**: some more finishing touches to put on the AircraftToken code before publishing, including removing aircraft details after token burned

### Day 30: July 4, Saturday
**Today's Progress**: global variables and start Lottery.sol in udemy course, review data and msg intricacies

**Thoughts**: back to basics for refresher, next overview on arrays will be good review for AircraftToken.sol

### Day 29: July 3, Friday
**Today's Progress**: AircraftToken.sol now functional, token/aircraft details returnable by incrementing "i" number and pulling the "i"th Aircraft struct in the aircraft array of Aircraft structs, but searcher must input the "i" number which is not ideal. This can likely be solved either by several arrays or off-chain databases (public database storage of i numbers isn't a decentralization threat, just allows cheaper access to helpful search terms). tokenId/newAircraftId returns owner, which can be used to find the other information

**Thoughts**: eventually I would like to flesh out how to make tokens searchable by each attribute, but will re-focus on Udemy course and eventual escrow contract

### Day 28: July 2, Thursday
**Today's Progress**: newAircraftId now has unique value based on owner's regId and MSN of applicable aircraft, but still need to figure out how to pull token data/array info

**Thoughts**: more ERC721 learning to do-- tokenURI (uniform resource identifier) may be the answer. URIs are defined in RFC 3986

### Day 27: July 1, Wednesday
**Today's Progress**: aircraft NFT implementation seems to be working, tokensupply increments, but need to fix aircraftDetails function to return token info

**Thoughts**: need to look into how to pull details of a given ERC721 token, create a unique ID for newAircraftId, and learn more about calldata

### Day 26: June 30, Tuesday
**Today's Progress**: continue aircraft NFT implementation, intro to Git, ERC721 minting 

**Thoughts**: look into intricacies of mint v. safeMint function, need to make a practice of charting out function flow and matrixes, etc.

### Day 25: June 29, Monday
**Today's Progress**: successfully compiled AircraftToken.sol with receive() fix and minimum ETH payment, able to enter one aircraft

**Thoughts**: the fallback() v. receive() issue was strictly a version deprecation, need to be mindful of these. Next is tying info to actual NFT 
**To Do**: tie aircraft info to actual NFT-- will likely need to have buyRegToken then invoke createAircraft, which will be an internal function returning newAircraftID

### Day 24: June 28, Sunday
**Today's Progress**: dev AircraftToken.sol, including payable / fee for creation. Interaction of ERC721 and underlying structs

**Thoughts**: need to focus on how to return token details and maybe down the line, how to return a token's details given one of its parameters 
**To Do**: resolve AircraftToken's "this contract has a payable fallback function, but no receive ether function, consider adding one"

### Day 23: June 27, Saturday
**Today's Progress**: more work on CreateAircraft.sol, now fully using OZ's ERC721 code, will need several-day overhaul

**Thoughts**: better to use widely vetted code than reinventing the wheel wherever possible-- will consider the same for AircraftOwnership

### Day 22: June 25, Thursday
**Today's Progress**: revise CreateAircraft.sol, review Moloch code and potential divisibility uses for lexDAO's dripDrop

**Thoughts**: skipping next unit of Udemy course to prevent stasis from lack of javascript background

### Day 21: June 22, Monday
**Today's Progress**: analyze/replicate LexToken and other parts of lexDAO codebase, other review

**Thoughts**: taking a breather due to an overly busy workweek, but will use the Udemy course to stay up on concepts

### Day 20: June 21, Sunday
**Today's Progress**: experiment with dynamic array limitations, explore chainlink's dynamic NFTs for potential asset representation with native attributes and valuation 

**Thoughts**: will refocus on specific solidity concepts, such as using structs

### Day 19: June 20, Saturday
**Today's Progress**: explore 0x ERC721 implementation, including ERC-721JSON metadata file (https://github.com/0xcert/ethereum-erc721) 

**Thoughts**: will be useful to understand differences in audited ERC721 implementations, and how they can have dynamic attributes

### Day 18: June 19, Friday
**Today's Progress**: start CreateAircraft.sol and NFT considerations for FAA aircraft registry token, SafeMath

**Thoughts**: need to hone in on exact params and data types for the Aircraft ER721-- initially based on FAA registry attributes (i.e. no engines). Project is starting to take shape: escrow dApp that takes inputs of aircraft details, AdvanceRequirement satisfaction, and external data from oracles

### Day 17: June 18, Thursday
**Today's Progress**: Continue ERC721 portions of cryptozombies and map out intended NFT details

**Thoughts**: need to dive in deep to the implications of the transferTo v. approve standard, for owner to initiate transfer v. recipient requesting and owner approving

### Day 16: June 17, Wednesday
**Today's Progress**: revisit ERC721 portions of cryptozombies; continued background on web3 pack; review DMM code

**Thoughts**: begin to assemble components and params for an aircraft NFT; keeping momentum on the solidity side and will handle front end/web3 on the latter half of the challenge

### Day 15: June 16, Tuesday
**Today's Progress**: address array events; begin basic understanding of web3 pack

**Thoughts**: will likely eschew granular web3 concepts for viable nocode or prebuilt solutions so as not to be overwhelmed/inundated at first

### Day 14: June 15, Monday
**Today's Progress**: more practice with events and emit; seems event inputs need to match corresponding function params, clean up comments in AdvanceRequirement.sol

**Thoughts**: still looking for good documentation on events and their restrictions, need to test structs

### Day 13: June 14, Sunday
**Today's Progress**: exploring Mocha and javascript environments

**Thoughts**: looking for the most streamlined dev environment, the Udemy course recs may be outdated. May also be a viable nocode solution here

### Day 12: June 13, Saturday
**Today's Progress**: deploying contracts and ETH infrastructure; Udemy course; more event examples

**Thoughts**: would like to explore alternatives to the heavily used tools like truffle, infura, remix, for curiosity

### Day 11: June 12, Friday
**Today's Progress**: trial and error with strings- event and emit; Udemy course

**Thoughts**: an event is probably better for the whitelist array, but I'm not sure why entered strings can't be used as events

### Day 10: June 11, Thursday
**Today's Progress**: Udemy course-- function calls and details, editing/finalizing AdvanceRequirement.sol

**Thoughts:** as I learn about Solidity's unique function and storage considerations, I'll seek to minimize gas to the extent possible

### Day 9: June 10, Wednesday
**Today's Progress**: Udemy course-- unique function considerations in Solidity including gas, editing AdvanceRequirement pull request

**Thoughts:** I should explore more efficient workflows on github, beyond just opening PRs on my own contracts

### Day 8: June 9, Tuesday
**Today's Progress**: experimenting with whitelisting in Remix; Udemy course-- deployment and running functions considerations

**Thoughts:** need to learn how to check if an address exists in an array, and whether it is more efficient to (i) use boolean to decide whether to input an address in an array, or create a struct of addresses with their boolean status-- I think the former.  
**To Do:** decide whether to keep AdvanceRequirement streamlined (msg.sender or hardcoded address can mark as satisfied) and do the whitelisting in a separate contract or merge the PR

### Day 7: June 8, Monday
**Today's Progress**: experimenting with string input and memory/gas considerations in Remix; start Udemy course

**Thoughts:** having some issues with a "one time" input string, there is likely a simpler solution. Could also leave as a clause to be incorporated directly into an OpenLaw template, so the context is merely a reference.  
**To Do:** map the address of the favored party for AdvanceRequirement.sol and state change for the condition string, consider also triggering ERC721 transferTo

### Day 6: June 7, Sunday
**Today's Progress**: ERC721 Transfer standard and mappings, finish cryptozombies lesson 5: tokens, libraries (safemath)

**Thoughts:** the transferTo v. approve standard is important if I want (i) owner to initiate transfer or (ii) recipient to request and owner to approve (two steps). The former seems more relevant for ERC721 representing title, an interest, and/or permissioned access, latter perhaps for auctions

### Day 5: June 6, Saturday
**Today's Progress**: trial and error with strings in AdvanceRequirement.sol, start Udemy course and cryptozombies lesson 5: tokens

**Thoughts:** need to figure out how to have a whitelisted address input a string once that cannot be subsequently altered (even by that address); 

### Day 4: June 5, Friday
**Today's Progress**: create AdvanceRequirement.sol, finish cryptozombies lesson 4: random numbers, modifiers, if/else

**Thoughts:** important to keep track of the various instances where modifiers streamline, will need to look into other random number solutions (like chainlink's VRF)  
**To Do:** add a function to store the address of the favored party for AdvanceRequirement.sol and either hash the text of the requirement or input a description and section reference | _edit_: done, Day 8, but need to restrict via require()

### Day 3: June 4, Thursday
**Today's Progress**: Cryptozombies Lesson 4: for loops, payable, withdraws

**Thoughts:** _payable_ introduces some unique commercial and legal questions, in requiring a certain payment to the contract in order to execute a function in a single call (what if no performance? offer/acceptance issues?)
  require(msg.value == 0.001 ether);
  transferThing(msg.sender);
  js front-end: OnlineStore.buySomething({from: web3.eth.defaultAccount, value: web3.utils.toWei(0.001)})

### Day 2: June 3, Wednesday
**Today's Progress**: Cryptozombies Lesson 3 re-review: custom modifiers (onlyOwner, etc.) and declaring arrays; LexDAO hack call and discussing empty modifier call with @Ro5s, bool syntax

**Thoughts:** Shame contract: https://etherscan.io/address/0xee4550f61da479274a08e2396684cda7a8295a6e#code and tweet: https://twitter.com/r_ross_campbell/status/1267999654890876928?s=20

### Day 1: June 2, Tuesday
**Today's Progress**: Cryptozombies Lesson 3: external dependencies, ownable, modifiers, gas considerations, declaring arrays, for loops

**Thoughts:** Solidity has some unique considerations for gas, such as keeping as much in memory (instead of storage) as possible. I'll need a lot more practice with passing structs as arguments, declaring arrays, and modifiers. Visibility modifiers are imperative for confidentiality, security, IP, and many other considerations: _private_ means it's only callable from other functions inside the contract; _internal_ is like private but can also be called by contracts that inherit from this one; _external_ can only be called outside the contract; and _public_ can be called anywhere, both internally and externally

### Day 0: June 1, 2020
**Today's Progress**: Cryptozombies Lesson 2: interacting with other contracts, If statements, internal/external, storage/memory, require(), msg.sender

**Thoughts:** I'm going to need to emphasize the basic logic flow of arrays, interfaces, modifiers. 
