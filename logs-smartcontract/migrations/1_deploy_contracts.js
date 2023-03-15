var SimpleLogger = artifacts.require("SimpleLogger");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(SimpleLogger);
};