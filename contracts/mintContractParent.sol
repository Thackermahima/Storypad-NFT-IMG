// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./mintContract.sol";

contract mintContractParent is Ownable {
    struct emergencyAlert {
        address user;
        string subject;
        string message;
    }

    mapping(address => bool) private loginStatus;
    mapping(address => mapping(address => bool)) private transferStatus;
    mapping(address => address) private users;
    mapping(address => string[]) private members;

    mapping(address => uint256) private tokenIds;
    mapping(address => emergencyAlert) private alerts;
    mapping(address => string[]) private documents;

    event TokenCreated(address, address);
    event TokenTransfered(address, address, address, uint256);

    function getLoginStatus(address caller) public view returns (bool) {
        return loginStatus[caller];
    }

    function createToken(string memory name, string memory symbol) public {
        address _address = address(new mintContract(name, symbol)); // Created Token contract.

        emit TokenCreated(msg.sender, _address);
    }

    function bulkMintERC721(
        address tokenAddress,
        uint256 start,
        uint256 end,
        string[] memory tokenURI
    ) public {
        for (uint256 i = start; i < end; i++) {
            mintContract(tokenAddress).safeMint(msg.sender, tokenURI[i]);
        }
        loginStatus[msg.sender] = true;
        users[msg.sender] = tokenAddress;
        setTokenId(end - 1);
    }

    function transferToken(
        address from,
        address payable to,
        address token,
        uint256 amount
    ) public {
        mintContract(token).transferTokens(from, to, token, amount);
        transferStatus[from][to] = true;
        emit TokenTransfered(from, to, token, amount);
    }
    function setTokenId(uint256 tokenId) public {
        tokenIds[msg.sender] = tokenId;
    }

}


