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

    mapping(string => Proposal) public proposals;
    event CreatedProposalEvent(string name);
    event CreatedVoteEvent(string name);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owners or admins can add a proposal"
        );
        _;
    }

    //proposal name has to be unique
    function addProposal(
        string memory name,
        string memory description,
        string memory year
    ) public onlyOwner returns (bool) {
        Proposal memory proposal = Proposal({
            name: name,
            description: description,
            year: year
            //    votes:{}
        });
        proposals[name] = proposal;
        return true;
    }
}
