// SPDX-License-Identifier: MIT

pragma solidity > 0.8.0;

contract Storage {
    address payable private owner;
    uint256 number; 
    
    constructor() {
        owner = payable(msg.sender);
    } 
    
    function store(uint256 num) public payable {
        number = num;
    } 
    
    function retrieve() public view returns (uint256){
        return number;
    }
 
    function close() public { 
        selfdestruct(owner); 
    }
}