// originated and modified from Syndicate DAO's hiring test: https://github.com/SyndicateProtocol/Bank-Solidity-Hiring
// objective is to improve security of initial .sol file at https://github.com/SyndicateProtocol/Bank-Solidity-Hiring/blob/main/contracts/Bank.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

/// @title A sample bank contract
/// @author Will Papper and Syndicate Inc.
/// @notice The Bank contract keeps track of the deposits and withdrawals for a
/// single user. The bank takes a 0.3% fee on every withdrawal. The bank contract
/// supports deposits and withdrawals for any ERC-20, but only one ERC-20 token
/// can be used per bank contract.
/// @dev Security for the Bank contract is paramount :) You can assume that the
/// owner of the Bank contract is the first account in Ganache (accounts[0]
/// within Bank.js), and that the user of the bank is not the owner of the Bank
/// contract (e.g. the user of the bank is accounts[1] within Bank.js, not
/// accounts[0]).
contract Bank {
    // The contract address for DAI
    address public constant DAI_ADDRESS = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    // The contract address for USDC
    address public constant USDC_ADDRESS = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    // The address where bank fees should be sent
    address public constant BANK_FEE_ADDRESS = 0xcD0Bf0039d0F09CF93f9a05fB57C2328F6D525A3;
    address user;
    address ERC20_ADDRESS;

    uint256 balance = 0;

    // The bank should take a fee of 0.3% on every withdrawal. For example, if a
    // user is withdrawing 1000 DAI, the bank should receive 3 DAI. If a user is
    // withdrawing 100 DAI, the bank should receive .3 DAI. The same should hold
    // true for USDC as well.
    // The bankFee is set using setBankFee();
    uint256 bankFee = 0;

    IERC20 public erc20;

    /// @notice Process a deposit to the bank
    /// @param amount The amount that a user wants to deposit
    /// @return balance The current account balance
    function deposit(uint256 amount, address _ERC20_ADDRESS) public returns (uint256) {
        require(_ERC20_ADDRESS == DAI_ADDRESS || _ERC20_ADDRESS == USDC_ADDRESS, "submit either DAI or USDC address as chosen ERC20");
        user = msg.sender;
        ERC20_ADDRESS = _ERC20_ADDRESS;
        erc20 = IERC20(ERC20_ADDRESS);
        // Transfer funds from the user to the bank
        erc20.transferFrom(msg.sender, address(this), amount);

        // Increase the balance by the deposit amount and return the balance
        balance += amount;
        return balance;
    }

    /// @notice Process a withdrawal from the bank
    /// @param amount The amount that a user wants to withdraw. The bank takes a
    /// 0.3% fee on every withdrawal
    /// @return balance The current account balance
    function withdraw(uint256 amount) public returns (uint256) {
        require(msg.sender == user, "Only user may withdraw.");
        // Calculate the fee that is owed to the bank
        (uint256 amountToUser, uint256 amountToBank) = calculateBankFee(amount);

        erc20.transfer(user, amountToUser);
        // Decrease the balance by the amount sent to the user
        balance -= amountToUser;

        erc20.transfer(BANK_FEE_ADDRESS, amountToBank);
        // Decrease the balance by the amount sent to the bank
        balance -= amountToBank;

        return balance;
    }

    /// @notice Calculate the fee that should go to the bank
    /// @param amount The amount that a fee should be deducted from
    /// @return A tuple of (amountToUser, amountToBank)
    function calculateBankFee(uint256 amount) public view returns (uint256, uint256)
    {
        // TODO: Implement the 0.3% fee to the bank here
        uint256 amountToBank = amount * bankFee;
        uint256 amountToUser = amount - amountToBank;
        return (amountToUser, amountToBank);
    }

    /// @notice Set the fee that the bank takes
    /// @param fee The fee that bankFee should be set to
    /// @return bankFee The new value of the bank fee
    function setBankFee(uint256 fee) public returns (uint256) {
        bankFee = fee;
        return bankFee;
    }

    /// @notice Get the user's bank balance
    /// @return balance The balance of the user
    function getBalanceForBankUser() public view returns (uint256) {
        return balance;
    }
}
