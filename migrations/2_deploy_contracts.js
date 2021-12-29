const dlc = artifacts.require("DLC.sol");

module.exports = function(deployer) {
    deployer.deploy(dlc);
};