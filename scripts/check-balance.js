import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const token = await connection.ethers.getContractAt(
    "LaunchToken",
    "0xDEc095338bf60406A63B6948c64b063D68c50799"
  );

  const wallet = "0xd4d9FDbe7577aaa04B18a1bcFF4dE0CDbD3293c8";

  const balance = await token.balanceOf(wallet);
  const name = await token.name();
  const symbol = await token.symbol();

  console.log("Token:", name, `(${symbol})`);
  console.log("Wallet:", wallet);
  console.log("Raw balance:", balance.toString());
  console.log("Readable balance:", connection.ethers.formatUnits(balance, 18));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});