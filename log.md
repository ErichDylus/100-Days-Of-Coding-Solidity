# 100 Days Of Code - Solidity - Log

### Day 27: July 1, Wednesday
**Today's Progress**: aircraft NFT implementation seems to be working, tokensupply increments, but need to fix aircraftDetails function to return token info

**Thoughts**: need to look into how to pull details of a given ERC721 token, and learn more about calldata

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
