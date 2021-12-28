const Voting = artifacts.require("Voting")


module.exports = async function (callback) {
  
    const voting  =  await Voting.deployed();
    await voting.updateOwnership("0xe4Dd216FE09472Aec8a50461Ad60D261932312ca");
    console.log("updated ownership of the system !!!!!");

    callback();
}