// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "hardhat/console.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/Strings.sol";

// NOTE: Deploy this contract first
contract ReceiverCallDelegate {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        console.log(string.concat("Who call setVarsReceiver ", Strings.toHexString(uint256(uint160(msg.sender)), 20)));
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract CallerCallDelegate {
    event Response(bool success, bytes data);

    uint public num;
    address public sender;
    uint public value;

    function setVarsCaller(address _contract, uint _num) public payable {
        console.log(string.concat("Who call setVarsCaller ", Strings.toHexString(uint256(uint160(msg.sender)), 20)));
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        emit Response(success, data);
    }
}