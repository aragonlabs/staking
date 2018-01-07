var Migrations = artifacts.require("./Migrations.sol");
var StakingApp = artifacts.require("./StakingApp.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations)
  deployer.deploy(StakingApp)
}
