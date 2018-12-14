pragma solidity ^0.4.2;

/**
 * The VehicleOwner contract ...
     // Model of the vehicle : model, numberplate, id 
    // Store vehicle
    // Store number of vehicles registered. (for stakeholders)
 */
contract VehicleOwner {
	address public owner;
	uint[] timesstamp; 
	
	function VehicleOwner () public{
		owner = msg.sender;
		
	}	

    //only VehicleOwner can alter this contract.
    modifier onlyOwner() { 
        require (msg.sender == owner); 
        _; 
    }

    struct Vehicle {
        string vehicle_owner;   // name of the owner of the vehicle
        address owner_addr;     // address of the owner of the vehicle
        string model;           // model of the vehicle e.g c class
        string make;            // type of vehicle e.g Mercedes
        bytes32 vin;            // unique verification identification number
        bool initialized;       // process control variable. Check whether the vehicle already exists.
    }
	
    //Store Vehicles with their respective unique vin's. 
    mapping (bytes32 => Vehicle) private vehicles;
    
    //Is used later on to store vehicles under their respective vins's
    vehicles[vin] = Vehicle(addr,model,make,true);

    //For the wallet Store
    mapping (address => mapping(bytes32 => bool)) private vehicleWallet;
    
    //assigning vehicle to wallet
    vehicleWallet[msg.sender][vin] = true;

    //Events to trigger when a transaction has taken place.e.g CreatedNewVehicle, etc
    event NewVehicleAdded(address account, bytes32 vin, uint256 timesstamp);
    event RejectVehicle(address account, uint vin, string message);


    // Creates a new vehicle.
    function createNewVehicle (string model, string make, bytes32 vin) {
        if(!vehicles[vin].initialized) { // checks whether a vehicle with it's vin already exists
            RejectVehicle(msg.sender, vin, "Vehicle with ths identification number already exists"); // If it exists, reject the entry and throw a message.
            return; // throw back the entry
        }

        vehicles[vin] = Vehicle(addr, model, make, true); // Vehicle'S vin is the unique id to store the vehicles
        vehicleWallet[msg.sender][vin] = true; // Links the vehicle to its wallet by id [vin]
        NewVehicleAdded(msg.sender, )
    }

    // gets all details of registered vehicles
    function getVehicle () constant returns (string) {
        return (vehicles.addr);
    }   
}

/**
 * The MyToken contract sends tokens from the service provider to the vehicle wallet
 
contract MyToken is VehicleOwner{
    //What is neede and can be changed
    //Constructor
    //Set total no. of tokens for service provider

    //Details of the tokens
    string public name = "Steinbeis token"; //Name of token
    string public symbol = "STB"; // symbol of token
    uint8 public decimals = 18; // same value as wei
    uint256 public totalSupply; // Initial supply token for service provider

    mapping (address => uint256) balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address _owner, address _spender, uint256 _value);

    function stbToken (uint256 _initialsupply) public {
        balanceOf[msg.sender] = _initialsupply;
        totalSupply = _initialsupply; //initial balance of service provider
    }
    
    
    
    
}
*/