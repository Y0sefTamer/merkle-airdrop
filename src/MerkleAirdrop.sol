// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {
    using SafeERC20 for IERC20;
    // custom error
    error MerkleAirdrop_Invalidproof();
    error MerkleAirdrop_AlreadyClaimed();

    address[] claimers;
    bytes32 immutable i_merkleRoot;
    IERC20 immutable i_airdropToken;
    mapping(address claimer => bool claimed) private s_hasClaimed;

    event Claim(address indexed account, uint256 amount);

    constructor(bytes32 merkleRoot, IERC20 airdropToken) {
        i_merkleRoot = merkleRoot;
        i_airdropToken = airdropToken;
    }

    function claim(address account, uint256 amount, bytes32[] calldata merkleProof) external {
        // Verify the proof and claim the airdrop
        if (s_hasClaimed[account]) {
            revert MerkleAirdrop_AlreadyClaimed();
        }
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
        if (!MerkleProof.verify(merkleProof, i_merkleRoot, leaf)) {
            revert MerkleAirdrop_Invalidproof();
        }
        s_hasClaimed[account] = true;
        claimers.push(account);
        i_airdropToken.safeTransfer(account, amount);
        emit Claim(account, amount);
    }

    function getClaimers() external view returns (address[] memory) {
        return claimers;
    }

    function getMerkleRoot() external view returns (bytes32) {
        return i_merkleRoot;
    }

    function getAirdropToken() external view returns (IERC20) {
        return i_airdropToken;
    }
}
