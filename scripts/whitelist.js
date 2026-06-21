import { network } from "hardhat";

async function main() {
  const connection = await network.connect();

  const presaleAddress = "0x335B7362282eC6ec1bDd80D60c3eAD084d788946";
  const buyer = "0xd4d9FDbe7577aaa04B18a1bcFF4dE0CDbD3293c8";

  const presale = await connection.ethers.getContractAt(
    "TokenPresale",
    presaleAddress
  );

  const tx = await presale.addToWhitelist(buyer);
  await tx.wait();

  console.log("Whitelisted:", buyer);
  console.log("Improved presale:", presaleAddress);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});