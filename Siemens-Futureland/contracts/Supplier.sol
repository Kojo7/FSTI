pragma solidity^0.4.20;

import "./Appendix1.sol";
import "./Appendix2.sol";

contract Supplier {

    address app1Address;
    address app2Address;

    constructor (address app1Addr, address app2Addr) public {
        app1Address = app1Addr;
        app2Address = app2Addr;
    }

    function getRequests() public returns(uint[]) {
        Appendix1 app1 = Appendix1(app1Address);
        return app1.getRequests();
    }

    //clearRequests
    function clearRequests() public {
        Appendix1 app1 = Appendix1(app1Address);
        app1.clearRequests();
    }

    function getSpecificRequest(uint modelID) public returns(string) {
        Appendix1 app1 = Appendix1(app1Address);
        return app1.getRequest(modelID);
    }

    function sendSupply(uint modelID, int your_temperature, string _addr) public {
        Appendix1 app1 = Appendix1(app1Address);
        Appendix2 app2 = Appendix2(app2Address);
        string memory material = getSpecificRequest(modelID);
        var penalty = app2.checkThreshold(material, your_temperature);
        if (penalty != 0) {
            if (app2.sendPenalty(penalty) == true) {
                app1.sendSupply(modelID, your_temperature, _addr);
            }
            else {
                throw;
            }
        }
        else {
            app1.sendSupply(modelID, your_temperature, _addr);
        }
    }

    function getBalance() public returns(uint) {
        Appendix2 app2 = Appendix2(app2Address);
        return app2.getBalance();
    }
}