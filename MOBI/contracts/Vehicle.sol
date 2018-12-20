pragma solidity ^0.4.20;

/**
 * The vehicle contract stores the vehicle information...
 */
contract Vehicle {
    
    function Vehicle() public {
        vehicle = msg.sender;
        
    }
    
    address vehicle;
    
    modifier onlyVehicle {
        require(msg.sender == vehicle);
        _;
        }
    //modifier onlyVehicle { if (msg.sender != vehicle) revert; _;}
    
    //Date struct to 
    struct Date {
        uint16 year;
        uint8 month;
        uint8 day;
    }
    
    //struct contains vehicle info
    struct vehicleInfo {
        Date date;
        string owner;
        string make;
    }

    Date date;
    vehicleInfo vInfo;

    //vin is considered unique to every vehicle
    mapping(uint => vehicleInfo) vehicleList;

    //Creat new vehicles
    function setVehicle (uint vin, string name, string model, uint16 y, uint8 m, uint8 d) public onlyVehicle {
        date = Date(y, m, d);
        vehicleList[vin].owner = name;
        vehicleList[vin].make = model;
        vehicleList[vin].date = date; 
    }

    //get vehicle information by id[vin]
    function getVehicleInfo (uint vin) public onlyVehicle constant returns(uint, string, string, uint16, uint8, uint8) {
        return (vin, vehicleList[vin].owner, vehicleList[vin].make, vehicleList[vin].date.year, vehicleList[vin].date.month, vehicleList[vin].date.day);        
        }
    
    //function getVehicleVin () onlyVehicle public constant returns (uint) {
      //  return vin;
    //}
} 