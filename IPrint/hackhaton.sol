pragma solidity >=0.4.22 < 0.6.0;

import "ownable.sol";

contract owner is Ownable {
    
    address private _owner;
    
    //struct HashOwner {
      //  string Hash;
    //}
    string Hash;
    address Address;
    //address[] public Hashowners;
    
    mapping (address => string) public printOwners; // Mapping address of owner to HashValues;
    //mapping (string => address) hashowner; // Mapping hash value to owners;
    //mapping (address => HashOwner) owners; // List of all owners and hash values;
    

    function setHashValue(string _Hash, address _Address) external {
        //owners[msg.sender].Hash = _Hash;
        Hash = _Hash;
        Address = _Address;
        printOwners[_Address] = _Hash;
        //hashowner[_Hash] = _Address;
        
    }
    
    //function getHashValue(address _address) view external returns(string) {
      //  return (owners[_address].Hash);
    //}
    
}