// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract CossackTraditionsRegistry {

    struct CossackTradition {
        string traditionName;       // Don Cossack Song, Kuban Dance, Terek Horsemanship, etc.
        string region;              // Don, Kuban, Terek
        string culturalElements;    // singing, dance, horsemanship, weaponry
        string techniques;          // vocal style, riding technique, sword handling
        string historicalContext;   // frontier defense, migrations, wars
        string attire;              // chokha, papakha, belts, embroidery
        string uniqueness;          // regional identity, rare variants
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct CossackInput {
        string traditionName;
        string region;
        string culturalElements;
        string techniques;
        string historicalContext;
        string attire;
        string uniqueness;
    }

    CossackTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event CossackRecorded(uint256 indexed id, string traditionName, address indexed creator);
    event CossackVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            CossackTradition({
                traditionName: "Example (replace manually)",
                region: "example",
                culturalElements: "example",
                techniques: "example",
                historicalContext: "example",
                attire: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordCossack(CossackInput calldata c) external {
        traditions.push(
            CossackTradition({
                traditionName: c.traditionName,
                region: c.region,
                culturalElements: c.culturalElements,
                techniques: c.techniques,
                historicalContext: c.historicalContext,
                attire: c.attire,
                uniqueness: c.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit CossackRecorded(traditions.length - 1, c.traditionName, msg.sender);
    }

    function voteCossack(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        CossackTradition storage c = traditions[id];

        if (like) c.likes++;
        else c.dislikes++;

        emit CossackVoted(id, like, c.likes, c.dislikes);
    }

    function totalCossack() external view returns (uint256) {
        return traditions.length;
    }
}
