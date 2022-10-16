// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Ballot {

    enum VoteOption { Car, Bus, OnFoot }

    struct Vote { 
        bool voted;
        address delegate;
        VoteOption vote;
    }

    uint numVote;
    mapping (uint => Vote) votes;

    function newVote(address citizen, VoteOption option) public returns (uint voteID) {
        voteID = numVote++;
        Vote storage vot = votes[voteID];
        vot.voted = true;
        vot.delegate = citizen;
        vot.vote = option;
    }

    function getVote(uint numberOfVote) public view returns (uint option) {
        return uint(votes[numberOfVote].vote);
    }
}