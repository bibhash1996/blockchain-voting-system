const Voting  = artifacts.require("Voting");

module.exports = async(deployer,network) => {
    await deployer.deploy(Voting);
}