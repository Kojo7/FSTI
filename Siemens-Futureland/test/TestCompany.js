var Company = artifacts.require("./Company.sol");
var Customer = artifacts.require("./Customer.sol");
var Supplier = artifacts.require("./Supplier.sol");

Customer.deployed().then(function(i){return i.proposeDemand("table holder", "carry >100kg, turn on fast", {from:"0xa1270Df7fC2DEf14386848F9C1B02EfF89fefE75"})});




contract('Company', function() {
    it("The demand was proposed and gotten", function () {
        return Company.deployed().then(function (instance) {
            return instance.getDemands.call({from: "0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76"});
        }).then(function (result) {
            assert.equal(result[0].valueOf(), 1234, "Not done!");
        });
    });
});

Company.deployed().then(function(i){return i.storeModel(1234,"Anna","http://annasmodel.com","steel",150,3,{from: "0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76"})});

contract('Company', function() {
    it("The model is stored and the supply is asked for, we access this model", function () {
        return Company.deployed().then(function (instance) {
            return instance.getModel.call(1234,{from: "0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76"});
        }).then(function (result) {
            assert.equal(result[0].valueOf(), "table holder", "Not done!");
        });
    });
});

contract('Supplier', function() {
    it("The supply was asked for and gotten", function () {
        return Supplier.deployed().then(function (instance) {
            return instance.getRequests.call({from: "0x43439Cca7E74523262b2C757c874aa09969C1c9e"});
        }).then(function (result) {
            assert.equal(result[0].valueOf(), 1234, "Not done!");
        });
    });
});


Supplier.deployed().then(function(i){return i.sendSupply(1234,37,"some storage where you can access your supply",{from: "0x43439Cca7E74523262b2C757c874aa09969C1c9e"})});

contract('Company', function() {
    it("The address of the supply sent", function () {
        return Company.deployed().then(function (instance) {
            return instance.getSupply.call(1234,{from: "0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76"});
        }).then(function (result) {
            assert.equal(result.valueOf(), "some storage where you can access your supply", "Not done!");
        });
    });
});