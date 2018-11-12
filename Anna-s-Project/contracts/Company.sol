pragma solidity^0.4.20;

import "./Customer.sol";
import "./Appendix1.sol";
import "./DateTime.sol";
import "./Strings.sol";
import "./Appendix3.sol";

contract Company {

    using Strings for string;

    address customerContractAddress;
    address app1Address;
    address companyAddress = 0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76;
    address app3Address;

    constructor (address customerAddr, address app1Addr) public {
        customerContractAddress = customerAddr;
        app1Address = app1Addr;
    }

    modifier onlyCompany() {
        require(tx.origin == companyAddress);
        _;
    }

    DateTime datetime = new DateTime();

    struct Model {
        string name;
        string author;
        uint _day;
        uint _month;
        uint _year;
        string path;
        address customerAddr;
    }

    mapping(uint => Model) models;

    struct Prototype {
        string name;
        uint _day;
        uint _month;
        uint _year;
        string path;
        address customerAddr;
    }

    mapping(uint => Prototype) prototypes;

    //getTime (only in the other functions)
    function getTime() internal returns(uint, uint, uint) {
        uint currentDay = datetime.getDay(now);
        uint currentMonth = datetime.getMonth(now);
        uint currentYear = datetime.getYear(now);
        return (currentDay, currentMonth, currentYear);
    }

    //(just for the user)
    function presentTime(uint _day, uint _month, uint _year) internal returns(string) {
        string memory dayInString = datetime.uinttostr(_day);
        string memory monthInString = datetime.uinttostr(_month);
        string memory yearInString = datetime.uinttostr(_year);
        string memory fullDate = dayInString.concat(".").concat(monthInString).concat(".").concat(yearInString);
        return (fullDate);
    }

    function getDemands() public returns(uint[]) {
        Customer customer = Customer(customerContractAddress);
        return customer.getUnprocessed();
    }

    function clearDemands() public {
        Customer customer = Customer(customerContractAddress);
        customer.clearUnprocessed();
    }

    //get demand
    function getSpecificDemand(uint demandID) returns(string, string, address) {
        Customer customer = Customer(customerContractAddress);
        return customer.getDemand(demandID);
    }

    //store model
    function storeModel(uint demandID, string _author, string _path, string _material, uint req1, uint req2) onlyCompany public {
        Model model = models[demandID];
        var (name, _details, customerAddress) = getSpecificDemand(demandID);
        model.name = name;
        model.author = _author;
        var (nowDay, nowMonth, nowYear) = getTime();
        model._day = nowDay;
        model._month = nowMonth;
        model._year = nowYear;
        model.path = _path;
        model.customerAddr = customerAddress;
        Appendix3 app3 = new Appendix3(req1, req2);
        app3Address = address(app3);
        askForSupply(demandID, _material);
    }

    //askForSupply (in the other function)
    function askForSupply(uint modelID, string _material) internal {
        Appendix1 app1 = Appendix1(app1Address);
        app1.makeRequest(modelID, _material);
    }

    //get Supply
    function getSupply(uint modelID) onlyCompany public returns(string) {
        Appendix1 app1 = Appendix1(app1Address);
        return app1.getSupply(modelID);
    }

    //get Model (both on its own and in the other function)
    function getModel(uint modelID) onlyCompany public returns(string, string, string, string) {
        string memory _date = presentTime(models[modelID]._day, models[modelID]._month, models[modelID]._year);
        return(models[modelID].name, models[modelID].author, models[modelID].path, _date);
    }

    //storePrototype
    function storePrototype(uint prototypeID, string _path) onlyCompany public {
        Prototype prototype = prototypes[prototypeID];
        prototype.name = models[prototypeID].name;
        var (nowDay, nowMonth, nowYear) = getTime();
        prototype._day = nowDay;
        prototype._month = nowMonth;
        prototype._year = nowYear;
        prototype.path = _path;
        prototype.customerAddr = models[prototypeID].customerAddr;
    }

    //get prototype (on its own and to test it)
    function getPrototype(uint prototypeID) onlyCompany public returns(string, address, string, string) {
        string memory _date = presentTime(prototypes[prototypeID]._day, prototypes[prototypeID]._month, prototypes[prototypeID]._year);
        return(prototypes[prototypeID].name, prototypes[prototypeID].customerAddr, prototypes[prototypeID].path, _date);
    }

    //release prototype
    function releasePrototype(uint prototypeID, string _link, uint req1, uint req2) onlyCompany public {
        Appendix3 app3 = Appendix3(app3Address);
        if (app3.checkRequirements(req1, req2)) {
            Customer customer = Customer(customerContractAddress);
            var (name, customerAddr, path, date) = getPrototype(prototypeID);
            customer.storePrototype(name, _link, customerAddr, path, date);
        }
        else {
            throw;
        }
    }


}