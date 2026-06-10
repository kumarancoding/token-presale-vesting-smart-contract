// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LaunchToken.Sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenPresale is Ownable {

    LaunchToken public token;

    uint256 public tokenPrice = 0.001 ether;

    uint256 public minBuy = 0.01 ether;
    uint256 public maxBuy = 1 ether;

    bool public saleActive = true;

    mapping(address => bool) public whitelist;

    constructor(address tokenAddress)
    Ownable(msg.sender)
    {
        token = LaunchToken(tokenAddress);
    }

    function addToWhitelist(address user)
        external
        onlyOwner
    {
        whitelist[user] = true;
    }

    function removeFromWhitelist(address user)
        external
        onlyOwner
    {
        whitelist[user] = false;
    }

    function pauseSale()
        external
        onlyOwner
    {
        saleActive = false;
    }

    function resumeSale()
        external
        onlyOwner
    {
        saleActive = true;
    }

    function buyTokens()
        external
        payable
    {
        require(saleActive, "Sale is paused");

        require(
            whitelist[msg.sender],
            "Not whitelisted"
        );

        require(
            msg.value >= minBuy,
            "Below minimum buy"
        );

        require(
            msg.value <= maxBuy,
            "Above maximum buy"
        );

        uint256 amount =
            (msg.value * 10 ** 18) / tokenPrice;

        token.transfer(msg.sender, amount);
    }

    function withdrawFunds()
        external
        onlyOwner
    {
        payable(owner()).transfer(
            address(this).balance
        );
    }
}