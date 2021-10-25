//const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const {deployer, tokenOwner} = await getNamedAccounts();
  await deploy('RentToken', {
    from: deployer,
    args: [],
    log: true,
  });
};
module.exports.tags = ["RENT"];
