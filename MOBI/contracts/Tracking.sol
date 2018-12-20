pragma solidity ^0.4.20;
pragma experimental ABIEncoderV2;

import "./Vehicle.sol";

//Tracking vehicle and save and get Location History
contract Tracking is Vehicle{
    
    struct Location {
        address delegate;
        uint128 longitude;
        uint128 latitude; 
    }

    struct Item {
        bytes32 id;   
    }

    Item public item;

    Location[] public locations;
    Location public recentLocation;

    mapping (bytes32 => Vehicle.vehicleInfo) vehitrack;
    
        
    function vehicleTracking(bytes32 id) public {
        // Limit gas
        locations.length = 100;
        item = Item({id: id});
    }

    function saveLocation (uint128 longitude, uint128 latitude) public {
        locations.push(Location({delegate: msg.sender, longitude: longitude, latitude: latitude})
        );
    }

    function getLocationHistory(uint256 idx) public constant returns (address delegate, uint128 longitude, uint128 latitude) {
        Location storage loc = locations[idx];
        return (loc.delegate, loc.longitude, loc.latitude);
    }

    function getLastLocation() public view returns (Location recentLocation) {
        recentLocation = locations[locations.length - 1];
        return (recentLocation);
    }
}