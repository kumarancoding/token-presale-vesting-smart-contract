import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const tokenAddress = "0xDEc095338bf60406A63B6948c64b063D68c50799";
  const saleTokenCap = connection.ethers.parseUnits("500000", 18);

  const TokenPresale =
    await connection.ethers.getContractFactory("TokenPresale");

  const presale = await TokenPresale.deploy(tokenAddress, saleTokenCap);

  await presale.waitForDeployment();

  console.log("Improved TokenPresale deployed to:", await presale.getAddress());
  console.log("LaunchToken address used:", tokenAddress);
  console.log(
    "Sale token cap:",
    connection.ethers.formatUnits(saleTokenCap, 18),
    "LTT"
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});