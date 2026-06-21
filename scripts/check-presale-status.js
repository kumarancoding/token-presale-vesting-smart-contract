import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const tokenAddress = "0xDEc095338bf60406A63B6948c64b063D68c50799";
  const presaleAddress = "0x335B7362282eC6ec1bDd80D60c3eAD084d788946";
  const wallet = "0xd4d9FDbe7577aaa04B18a1bcFF4dE0CDbD3293c8";

  const token = await connection.ethers.getContractAt(
    "LaunchToken",
    tokenAddress
  );

  const presale = await connection.ethers.getContractAt(
    "TokenPresale",
    presaleAddress
  );

  const walletBal = await token.balanceOf(wallet);
  const presaleBal = await token.balanceOf(presaleAddress);
  const ethRaised = await connection.ethers.provider.getBalance(presaleAddress);

  const userEthSpent = await presale.ethSpentByUser(wallet);
  const userTokensPurchased = await presale.tokensPurchasedByUser(wallet);
  const totalTokensSold = await presale.totalTokensSold();
  const saleTokenCap = await presale.saleTokenCap();
  const remaining = await presale.remainingTokensForSale();

  console.log("===== Improved Presale Status =====");
  console.log("Wallet LTT:", connection.ethers.formatUnits(walletBal, 18));
  console.log("Presale LTT:", connection.ethers.formatUnits(presaleBal, 18));
  console.log("Presale ETH:", connection.ethers.formatEther(ethRaised));
  console.log("Sale active:", await presale.saleActive());

  console.log("User ETH spent:", connection.ethers.formatEther(userEthSpent));
  console.log(
    "User tokens purchased:",
    connection.ethers.formatUnits(userTokensPurchased, 18)
  );

  console.log(
    "Total tokens sold:",
    connection.ethers.formatUnits(totalTokensSold, 18)
  );
  console.log(
    "Sale token cap:",
    connection.ethers.formatUnits(saleTokenCap, 18)
  );
  console.log(
    "Remaining tokens for sale:",
    connection.ethers.formatUnits(remaining, 18)
  );
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});