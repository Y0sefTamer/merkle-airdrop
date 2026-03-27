// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract MerkleAirdrop {
    address[] claimers;
    bytes32 immutable i_merkleRoot;
    IERC20 immutable i_airdropToken;

    cunstructor(bytes32 merkleRoot, IERC20 airdropToken) {
        i_merkleRoot = merkleRoot;
        i_airdropToken = airdropToken
    }  

}
