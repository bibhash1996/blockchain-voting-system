pragma solidity ^0.6.0;

contract Voting {
    address owner;

    struct Voter {
        string name;
        uint128 age;
        string houseAddress;
    }

    struct Vote {
        Voter voter;
        bool casted;
    }

    struct Proposal {
        string name;
        string description;
        string year;
        mapping(address => Vote) votes;
    }

    event CreatedProposalEvent(string name);
    event CreatedVoteEvent(string name);

    constructor() public {
        owner = msg.sender;
    }
}
