const hre = require("hardhat");

async function main() {
  const Chatapp = await hre.ethers.getContractFactory("Chatapp");
  const chatApp = await Chatapp.deploy();

  await chatApp.deployed();

  console.log(`Contract Address: ${chatApp.address}`);
}
main().catch((error)=>{
  console.error(error);
  process.exitCode = 1;
});