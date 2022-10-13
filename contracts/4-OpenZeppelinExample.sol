// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ConverterStringToBase64 {
    
    constructor() {}

    function toBase64(bytes calldata data) public pure returns (string memory)
    {
        return Base64.encode(data);
    }
}