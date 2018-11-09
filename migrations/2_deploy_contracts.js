var Company = artifacts.require("./Company.sol");
var Customer = artifacts.require("./Customer.sol");
var Supplier = artifacts.require("./Supplier.sol");
var Appendix1 = artifacts.require("./Appendix1.sol");
var Appendix2 = artifacts.require("./Appendix2.sol");

module.exports = function(deployer) {
    deployer.deploy(Appendix1, {from:"0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76"});
    deployer.deploy(Customer, {from:"0xa1270Df7fC2DEf14386848F9C1B02EfF89fefE75"}).then(function() {
        return deployer.deploy(Company, Customer.address, Appendix1.address, {from:"0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76"});
    });
    deployer.deploy(Appendix2, {from:"0x43439Cca7E74523262b2C757c874aa09969C1c9e"}).then(function() {
        return deployer.deploy(Supplier, Appendix1.address, Appendix2.address, {from:"0x43439Cca7E74523262b2C757c874aa09969C1c9e"});
    });
};
