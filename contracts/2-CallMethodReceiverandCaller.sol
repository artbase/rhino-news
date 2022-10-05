// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "hardhat/console.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/Strings.sol";

contract Receiver {
    event Received(address caller, uint amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback of receive was called");
    }

    receive() external payable {
        emit Received(msg.sender, msg.value, "Fallback of receive was called");
    }

    function showMessage(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);
        console.log("Now you call method showMessage from Receiver contract");
        console.log(string.concat("Who call showMessage ", Strings.toHexString(uint256(uint160(msg.sender)), 20)));

        return _x + 1;
    }
}


contract Caller {
    event Response(bool success, bytes data);

    function testCallShowMessage(address payable _addr) public payable {
        console.log("Now you call method testCallShowMessage from Caller contract");
        console.log(string.concat("Who call testCallShowMessage ", Strings.toHexString(uint256(uint160(msg.sender)), 20)));

        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 50000}(
            abi.encodeWithSignature("showMessage(string,uint256)", "call showMessage", 123)
        );

        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }
}