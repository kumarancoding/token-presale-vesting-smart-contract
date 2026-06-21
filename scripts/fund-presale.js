import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const tokenAddress = "0xDEc095338bf60406A63B6948c64b063D68c50799";
  const presaleAddress = "0x335B7362282eC6ec1bDd80D60c3eAD084d788946";

  const token = await connection.ethers.getContractAt(
    "LaunchToken",
    tokenAddress
  );

  // Fund the improved presale with 500,000 LTT
  const amount = connection.ethers.parseUnits("500000", 18);

  const tx = await token.transfer(presaleAddress, amount);
  await tx.wait();

  console.log("Sent LTT to improved presale");
  console.log("Presale:", presaleAddress);
  console.log("Amount:", connection.ethers.formatUnits(amount, 18), "LTT");
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});