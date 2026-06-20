import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const token = await connection.ethers.getContractAt(
    "LaunchToken",
    "0xf58E442C7dcFa68c510C827deF5CBb324A9b63a1"
  );

  console.log("Name:", await token.name());
  console.log("Symbol:", await token.symbol());
  console.log("Total Supply:", (await token.totalSupply()).toString());

  const signer = await connection.ethers.provider.getSigner();
  const ownerAddress = await signer.getAddress();

  console.log("Owner Address:", ownerAddress);
  console.log(
    "Owner Balance:",
    (await token.balanceOf(ownerAddress)).toString()
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});