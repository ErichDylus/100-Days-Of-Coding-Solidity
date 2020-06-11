# 100 Days Of Code - Solidity - Log

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
