// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract PlatziPunks is ERC721, ERC721Enumerable {

    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;
    address _owner;

    constructor(uint256 _maxSupply) ERC721("PlatziPunks", "PLPKS") {
        maxSupply = _maxSupply;
        _owner = msg.sender;
    }

   function mint() public payable {
        uint256 current = _idCounter.current();
        
        // pregunto si esta enviando 0.1 eth
        require( msg.value >= 0.1 ether, "Insufficient funds" );

        // me fijo si quedan PUNKS disponibles        
        require(current < maxSupply, "No PlatziPunks left :(");
        
        // transfiero los ethers
        payable(_owner).transfer( msg.value );

        // envio el NFT
        _safeMint(msg.sender, current);

        // incremento el contador
        _idCounter.increment();
    } 

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721 Metadata: URI query for nonexitent token"
        );

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "PlatziPunks #', tokenId,'", 
                "external_url": "http://brendasaavedra.com", 
                "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                "// TODO: Calculate image URL",
                '"}'
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    };
}

    // Override required
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
