// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LaunchToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenPresale is Ownable {
    LaunchToken public immutable token;

    uint256 public tokenPrice = 0.001 ether;
    uint256 public minBuy = 0.01 ether;
    uint256 public maxBuy = 1 ether;
    uint256 public maxTotalBuyPerWallet = 2 ether;

    bool public saleActive = true;

    mapping(address => bool) public whitelist;
    mapping(address => uint256) public ethSpentByUser;
    mapping(address => uint256) public tokensPurchasedByUser;

    uint256 public totalTokensSold;
    uint256 public saleTokenCap;

    event WhitelistUpdated(address indexed user, bool status);
    event SaleStatusChanged(bool saleActive);
    event TokensPurchased(
        address indexed buyer,
        uint256 ethPaid,
        uint256 tokenAmount
    );
    event FundsWithdrawn(address indexed owner, uint256 amount);
    event UnsoldTokensWithdrawn(address indexed owner, uint256 amount);
    event TokenPriceUpdated(uint256 oldPrice, uint256 newPrice);
    event BuyLimitsUpdated(
        uint256 minBuy,
        uint256 maxBuy,
        uint256 maxTotalBuyPerWallet
    );
    event SaleTokenCapUpdated(uint256 oldCap, uint256 newCap);

    constructor(address tokenAddress, uint256 _saleTokenCap) Ownable(msg.sender) {
        require(tokenAddress != address(0), "Invalid token address");
        require(_saleTokenCap > 0, "Sale cap must be > 0");

        token = LaunchToken(tokenAddress);
        saleTokenCap = _saleTokenCap;
    }

    function addToWhitelist(address user) external onlyOwner {
        whitelist[user] = true;
        emit WhitelistUpdated(user, true);
    }

    function removeFromWhitelist(address user) external onlyOwner {
        whitelist[user] = false;
        emit WhitelistUpdated(user, false);
    }

    function pauseSale() external onlyOwner {
        saleActive = false;
        emit SaleStatusChanged(false);
    }

    function resumeSale() external onlyOwner {
        saleActive = true;
        emit SaleStatusChanged(true);
    }

    function setTokenPrice(uint256 newPrice) external onlyOwner {
        require(newPrice > 0, "Price must be > 0");
        uint256 oldPrice = tokenPrice;
        tokenPrice = newPrice;
        emit TokenPriceUpdated(oldPrice, newPrice);
    }

    function setBuyLimits(
        uint256 _minBuy,
        uint256 _maxBuy,
        uint256 _maxTotalBuyPerWallet
    ) external onlyOwner {
        require(_minBuy > 0, "Min buy must be > 0");
        require(_maxBuy >= _minBuy, "Max buy must be >= min buy");
        require(
            _maxTotalBuyPerWallet >= _maxBuy,
            "Wallet cap must be >= max buy"
        );

        minBuy = _minBuy;
        maxBuy = _maxBuy;
        maxTotalBuyPerWallet = _maxTotalBuyPerWallet;

        emit BuyLimitsUpdated(_minBuy, _maxBuy, _maxTotalBuyPerWallet);
    }

    function setSaleTokenCap(uint256 newCap) external onlyOwner {
        require(newCap >= totalTokensSold, "New cap below sold amount");
        uint256 oldCap = saleTokenCap;
        saleTokenCap = newCap;
        emit SaleTokenCapUpdated(oldCap, newCap);
    }

    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH to withdraw");

        payable(owner()).transfer(balance);
        emit FundsWithdrawn(owner(), balance);
    }

    function withdrawUnsoldTokens(uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be > 0");

        uint256 contractBalance = token.balanceOf(address(this));
        require(contractBalance >= amount, "Not enough tokens in contract");

        token.transfer(owner(), amount);
        emit UnsoldTokensWithdrawn(owner(), amount);
    }

    function buyTokens() external payable {
        require(saleActive, "Sale is paused");
        require(whitelist[msg.sender], "Not whitelisted");
        require(msg.value >= minBuy, "Below minimum buy");
        require(msg.value <= maxBuy, "Above maximum buy");

        require(
            ethSpentByUser[msg.sender] + msg.value <= maxTotalBuyPerWallet,
            "Wallet total buy limit exceeded"
        );

        uint256 tokenAmount = (msg.value * 1e18) / tokenPrice;
        require(tokenAmount > 0, "Zero token amount");

        require(
            totalTokensSold + tokenAmount <= saleTokenCap,
            "Sale cap exceeded"
        );

        require(
            token.balanceOf(address(this)) >= tokenAmount,
            "Not enough tokens in presale"
        );

        ethSpentByUser[msg.sender] += msg.value;
        tokensPurchasedByUser[msg.sender] += tokenAmount;
        totalTokensSold += tokenAmount;

        token.transfer(msg.sender, tokenAmount);

        emit TokensPurchased(msg.sender, msg.value, tokenAmount);
    }

    function remainingTokensForSale() external view returns (uint256) {
        return saleTokenCap - totalTokensSold;
    }
}