pragma solidity ^0.6.0;

contract Voting {
    address owner;

    struct Voter {
        address voterId;
        string name;
        uint128 age;
        string mobile;
        string houseAddress;
        bool isValue;
    }

    struct Vote {
        Voter voter;
        bool casted;
    }

    struct Proposal {
        string name;
        string description;
        string year;
        uint256 totalVotes;
        bool isValid;
        mapping(address => Vote) votes;
    }

    mapping(string => Proposal) public proposals;
    mapping(address => Voter) public voters;

    //Each mobile device is considered as a new voter device.
    mapping(string => bool) uniqueVoters;

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

    //String lower case
    function _toLower(string memory str) internal pure returns (string memory) {
        bytes memory bStr = bytes(str);
        bytes memory bLower = new bytes(bStr.length);
        for (uint256 i = 0; i < bStr.length; i++) {
            // Uppercase character...
            if ((uint8(bStr[i]) >= 65) && (uint8(bStr[i]) <= 90)) {
                // So we add 32 to make it lowercase
                bLower[i] = bytes1(uint8(bStr[i]) + 32);
            } else {
                bLower[i] = bStr[i];
            }
        }
        return string(bLower);
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
            year: year,
            isValid: true,
            totalVotes: 0
            //    votes:{}
        });
        proposals[name] = proposal;
        return true;
    }

    //voter id has to be unique
    function addVoter(
        string memory name,
        uint128 age,
        string memory mobile,
        string memory houseAddress
    ) public onlyOwner returns (bool) {
        require(uniqueVoters[mobile] == true, "Duplicate voter found.");
        Voter memory voter = Voter({
            voterId: msg.sender,
            name: name,
            age: age,
            houseAddress: houseAddress,
            mobile: mobile,
            isValue: true
        });
        voters[msg.sender] = voter;
        uniqueVoters[mobile] = true;
        return true;
    }

    function vote(string memory proposalName) public returns (bool) {
        require(
            voters[msg.sender].isValue == false,
            "Invalid voter. Voter not present"
        );
        require(proposals[proposalName].isValid == false, "Invalid proposal.");
        require(
            proposals[proposalName].votes[msg.sender].casted == true,
            "Voter has already voted."
        );
        proposals[proposalName].votes[msg.sender].casted = true;
        proposals[proposalName].totalVotes += 1;
        return true;
    }
}
