// SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BegleToken} from "../src/BegleToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";

contract MerkleAirdropTest is Test {
    BegleToken private token;
    MerkleAirdrop private airdrop;

    function setUp() public {
        token = new BegleToken();
        // mint some tokens to the airdrop contract
        token.mint(address(this), 1000 * 10 ** 18);
        // create a merkle tree with 3 accounts and their corresponding amounts
        bytes32[] memory merkleProof1 = new bytes32[](2);
        bytes32[] memory merkleProof2 = new bytes32[](2);
        bytes32[] memory merkleProof3 = new bytes32[](2);
        merkleProof1[0] = keccak256(abi.encode(address(0x123), 100 * 10 ** 18));
        merkleProof1[1] = keccak256(abi.encode(address(0x456), 200 * 10 ** 18));
        merkleProof2[0] = keccak256(abi.encode(address(0x123), 100 * 10 ** 18));
        merkleProof2[1] = keccak256(abi.encode(address(0x789), 300 * 10 ** 18));
        merkleProof3[0] = keccak256(abi.encode(address(0x456), 200 * 10 ** 18));
        merkleProof3[1] = keccak256(abi.encode(address(0x789), 300 * 10 ** 18));
        bytes32 merkleRoot = keccak256(
            bytes.concat(
                keccak256(abi.encode(address(0x123), 100 * 10 ** 18)),
                keccak256(abi.encode(address(0x456), 200 * 10 ** 18)),
                keccak256(abi.encode(address(0x789), 300 * 10 ** 18))
            )
        );
        airdrop = new MerkleAirdrop(merkleRoot, token);
    }

    function testClaim() public {
        // claim the airdrop for the first account
        airdrop.claim(address(0x123), 100 * 10 ** 18, new bytes32[](2));
        // check that the balance of the first account is correct
        assertEq(token.balanceOf(address(0x123)), 100 * 10 ** 18);
    }
}
