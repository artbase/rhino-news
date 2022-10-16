// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/Strings.sol";

contract StringsTest {

    constructor() {}

    function toString(uint256 value) public pure returns (string memory) {
        return Strings.toString(value);
    }

    function toHex(string memory s1) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(s1));
    }

    function compare(string memory s1, string memory s2) public pure returns (bool) {
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
    
    function concatenate(string memory s1, string memory s2) public pure returns (string memory) {
        return string(abi.encodePacked(s1, s2));
    }
}