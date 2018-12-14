pragma solidity ^0.4.2;

/**
 * The VehicleOwner contract ...
 */
contract VehicleOwner {
	address public owner;
	mapping (bytes32 => address) public vehicles; 
	uint[] timesstamp; 

	event NewVehicleAdded(address indexed newVehicle, uint256 timesstamp);
	
	function VehicleOwner () public{
		owner = msg.sender;
		
	}	

    modifier onlyOwner() { 
        require (msg.sender == owner); 
        _; 
    }

    // Model of the vehicle : model, numberplate, id 
    // Store vehicle
    // Store number of vehicles registered. (for stakeholders)
    struct Vehicle {
        address addr;
        string model;
        string make;
        bytes32 vin;
    }
	
    /**
    * @dev Throws if called by any account other than the owner.
    */
    // model:(e.g c class), make:(e.g Mercedes Benz),vin:(e.g 235698 this will be the id of every car.) 
    function createNewVehicle (string model, string make, bytes32 vin) public onlyOwner returns (bool success) {
    	address newVehicle = new Vehicle(model, make, vin);
    	vehicles[vin] = newVehicle;
    	NewVehicleAdded(newVehicle, now);
        return true;
    }

    // gets all details of registered vehicles
    function getVehicle () constant returns (address) {
        return newVehicle;
    }   
}

/**
 * The MyToken contract sends tokens from the service provider to the vehicle wallet
 */
contract MyToken is VehicleOwner{
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
