// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract Hero {
    address owner;
    string hero;

    constructor(string memory _hero)
    {
        owner=msg.sender;
        hero=_hero;
    }
    
    function setHero(string memory _hero)public
    {
        require(msg.sender==owner,"Not the owner");
        hero =_hero;
    }

    function getHero() public view returns(string memory)
    {
        return hero;
    }
    
}