//var VehicleWallet = artifacts.require("./VehicleWallet.sol")
var vehicle = artifacts.require("./Vehicle.sol");
var Tracking = artifacts.require("./Tracking.sol");

module.exports = function(deployer) {
  deployer.deploy(vehicle);
  deployer.deploy(vehicle);
};
