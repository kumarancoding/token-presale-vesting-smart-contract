// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VestingVault {

    struct Vesting {
        uint256 totalAmount;
        uint256 claimedAmount;
        uint256 releaseTime;
    }

    mapping(address => Vesting) public vestings;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function createVesting(
        address user,
        uint256 amount,
        uint256 releaseTime
    ) external onlyOwner {

        vestings[user] = Vesting({
            totalAmount: amount,
            claimedAmount: 0,
            releaseTime: releaseTime
        });
    }

    function claimTokens() external {

        Vesting storage vesting = vestings[msg.sender];

        require(block.timestamp >= vesting.releaseTime, "Still locked");

        uint256 claimable =
            vesting.totalAmount - vesting.claimedAmount;

        require(claimable > 0, "Nothing to claim");

        vesting.claimedAmount += claimable;
    }
}