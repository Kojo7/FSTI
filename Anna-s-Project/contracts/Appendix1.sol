pragma solidity^0.4.20;

contract Appendix1 {

    address companyAddress = 0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76;
    address supplierAddress = 0x43439Cca7E74523262b2C757c874aa09969C1c9e;

    modifier onlyCompany() {
        require(tx.origin == companyAddress);
        _;
    }

    modifier onlySupplier() {
        require(tx.origin == supplierAddress);
        _;
    }

    struct Supply {
        string material;
        uint requestTime;
        uint operationTime;
        int temperature;
        string addr;
    }

    uint[] newRequests;
    mapping(uint => Supply) supplies;

    function makeRequest(uint modelID, string _material) onlyCompany external {
        Supply supply = supplies[modelID];
        supply.material = _material;
        supply.requestTime = block.timestamp;
        newRequests.push(modelID) -1;
    }

    function getRequests() onlySupplier external returns(uint[]) {
        return newRequests;
    }

    //(only in UI)
    function clearRequests() onlySupplier external {
        delete newRequests;
    }

    function getRequest(uint modelID) onlySupplier external returns(string) {
        return (supplies[modelID].material);
    }

    function sendSupply(uint modelID, int _temp, string _addr) onlySupplier external {
        supplies[modelID].operationTime = block.timestamp - supplies[modelID].requestTime;
        supplies[modelID].temperature = _temp;
        supplies[modelID].addr = _addr;
    }

    function getSupply(uint modelID) onlyCompany external returns(string) {
        return supplies[modelID].addr;
    }


}