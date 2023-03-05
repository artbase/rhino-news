# Solidity

## Basic
- Simple Smart Contract ✅
- Blockchain Basics ✅
  - transactions
  - blocks -> order selection mechanism
- Ethereum Virtual Machine ✅
  - EVM is isolated from the Internet
  - two type of accounts
  - transaction is a message with information about 'to whom', 'from who', payload and Ether
  - gas is a price of transaction
  - places for storing data: storage, memory and stack
  - delegatecall/callcode and libraries -> context from calling contract
  - creating contract from contract
  - deactivate and self-destruct
  - logs
- Layout of Solidity source file ✅
  - SPDX License Identifier: MIT, UNLICENSED
  - Version Pragma
  - Importing other Source Files
- Structure of contract ✅
  - State Variables
  - Functions
  - Function Modifiers
  - Events
  - Errors
  - Struct Types
  - Enum Types
- Types
- Units and variables
- Control Structures
- Assignment
- Scoping and Declarations
- Checked or Unchecked Arithmetic
- Error handling

## Contract
- Creating Contracts ✅
  - web3.eth.Contract
  - constructor is executed once and it is optional
  - only constructor is supported
  - after creating smart contract you get ABI 
  - cyclic creation dependencies are impossible
- Visibility ✅
  - 4 types of functions: external, public, internal and private
  - state variables can be only public, internal or private
- Getter Functions ✅
  - use this if variable should be available external
  - internal variable data = sth
  - external variable this.data()
  - you cannot get while array by default
- Function Modifiers  ✅
  - Modifiers can be use in smart conract and library (limited)
  - Modifiers cannot implicitily access or change the arguments and return values of functionsthey modify. Their values can only be passed to themexplicitly at the point of invocation.
- Constant and Immutable State Variables  ✅
  - constant
  - immutable
- Functions  ✅
  - 'free functions'
  - returning multiple values: functions can return more than one result
  - view function
  - pure functions
  - receive Ether function
  - fallback function
  - function overloading 
- Events
- Errors and the Revert Statment
- Inheritance
- Abstract Contracts
- Interfaces
- Libraries

## Advance
- Compiler
- Layout of State Variables in Storage
- Layout in Memory
- Layout of Call Data
- Cleaning Up Variables
- Source Mappings
- Optimizer
- Inline Assembly ✅
- Yul

## v 0.8.0
