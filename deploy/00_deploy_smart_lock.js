const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const lockContract = await deploy("SmartLock", {
    from: deployer,
    log: true,
  });
};
module.exports.tags = ["SmartLock"];
