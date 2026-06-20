import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const LaunchToken =
    await connection.ethers.getContractFactory("LaunchToken");

  const token = await LaunchToken.deploy();

  await token.waitForDeployment();

  console.log(
    "LaunchToken deployed to:",
    await token.getAddress()
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});