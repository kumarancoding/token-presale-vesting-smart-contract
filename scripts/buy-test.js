import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const presaleAddress = "0x335B7362282eC6ec1bDd80D60c3eAD084d788946";

  const presale = await connection.ethers.getContractAt(
    "TokenPresale",
    presaleAddress
  );

  // Buy with 0.01 ETH => 10 LTT at price 0.001 ETH
  const tx = await presale.buyTokens({
    value: connection.ethers.parseEther("0.01"),
  });

  await tx.wait();

  console.log("Buy successful on improved presale");
  console.log("Sent: 0.01 Sepolia ETH");
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});