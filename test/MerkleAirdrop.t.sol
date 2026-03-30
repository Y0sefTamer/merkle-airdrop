// SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {BegleToken} from "../src/BegleToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {DeployMerkleAirdrop} from "../script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is Test {
    BegleToken private token;
    MerkleAirdrop private airdrop;

    bytes32 private root = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private constant AMOUNT = 25 * 1e18;
    bytes32 private proof1 = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 private proof2 = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] private PROOF = [proof1, proof2];
    address private user;
    uint256 private userPrivateKey;

    function setUp() public {
        token = new BegleToken();
        // mint some tokens to the airdrop contract
        token.mint(token.owner(), 1000 * 10 ** 18);
        airdrop = new MerkleAirdrop(root, token);
        (user, userPrivateKey) = makeAddrAndKey("user");
        // transfer some tokens to the airdrop contract
        token.transfer(address(airdrop), 1000 * 10 ** 18);
    }

    function testClaim() public {
        // claim the airdrop for the first account
        // airdrop.claim(address(0x123), 100 * 10 ** 18, new bytes32[](2));
        // check that the balance of the first account is correct
        //assertEq(token.balanceOf(address(0x123)), 100 * 10 ** 18);
        uint256 startingBalance = token.balanceOf(user);

        vm.prank(user);
        airdrop.claim(user, AMOUNT, PROOF);

        uint256 endingBalance = token.balanceOf(user);
        console.log("ending balance: ", endingBalance);
        assertEq(endingBalance - startingBalance, AMOUNT);
    }
}
