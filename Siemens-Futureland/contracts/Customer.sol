pragma solidity^0.4.20;

import "./Strings.sol";

contract Customer {

    using Strings for string;

    uint demandCount = 1234;
    uint[] unprocessedDemands;
    address companyAddress = 0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76;

    modifier onlyCompany() {
        require(tx.origin == companyAddress);
        _;
    }

    struct Demand {
        string name;
        string details;
        address customerAddress;
    }

    mapping(uint => Demand) demands;

    struct Prototype {
        string _addr;
        string _date;
        string _link;
        string _feedback;
    }

    string public releasedPrototypes;
    mapping(string => address) nameAddress;
    mapping(address => Prototype) prototypes;
    mapping(string => string) nameLink;

    event proposeNewDemand (
        string _message
    );

    event getOneDemand (
        string _message
    );

    event getStoredDemands (
        string _message
    );

    function seePrototypes() public returns(string) {
        return releasedPrototypes;
    }

    function proposeDemand(string _name, string _details) public {
        Demand demand = demands[demandCount];
        demand.name = _name;
        demand.details = _details;
        demand.customerAddress = tx.origin;
        unprocessedDemands.push(demandCount) -1;
        demandCount += 1;
        nameAddress[_name] = tx.origin;
        emit proposeNewDemand("You created a demand");
    }

    function getDemand(uint demandID) onlyCompany external returns(string, string, address) {
        emit getOneDemand("You have accessed the demand information");
        return (demands[demandID].name, demands[demandID].details, demands[demandID].customerAddress);
    }

    function getUnprocessed() onlyCompany external  returns(uint[]) {
        emit getStoredDemands("You have accessed all demand ids");
        return unprocessedDemands;
    }

    function clearUnprocessed() onlyCompany external {
        delete unprocessedDemands;
    }

    function storePrototype(string name, string _link, address customer_addr, string prototype_addr, string prototype_date) onlyCompany external {
        Prototype prototype = prototypes[customer_addr];
        prototype._addr = prototype_addr;
        prototype._link = _link;
        prototype._date = prototype_date;
        nameAddress[name] = customer_addr;
        releasedPrototypes = releasedPrototypes.concat(", ").concat(name);
        nameLink[name] = _link;
    }

    function getPrototype(string name) public returns(string, string, string) {
        require(nameAddress[name]==tx.origin);
        return (prototypes[tx.origin]._addr, prototypes[tx.origin]._date, prototypes[tx.origin]._link);
    }

    function writeFeedback(string name, string feedback) public {
        require(nameAddress[name]==tx.origin);
        prototypes[tx.origin]._feedback = feedback;
    }

    function seePrototype(string name) public returns(string, string) {
        return (nameLink[name], prototypes[nameAddress[name]]._feedback);
    }
}