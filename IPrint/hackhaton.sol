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
    mapping (string => address) hashowner; // Mapping hash value to owners;
    //mapping (address => HashOwner) owners; // List of all owners and hash values;
    
    //Events
    event NewHashCreated(address Address, string Hash);
    
    
    //set hash value and address of owner of HashValue
    function setHashValue(string _Hash, address _Address) external {
        Hash = _Hash;
        Address = _Address;
        printOwners[_Address] = _Hash;
        hashowner[_Hash] = _Address;
        emit NewHashCreated(_Address,_Hash);
    }
    
    //get hash value base on address.
    function getHashValue(address _Address) view external returns(string) {
       return Hash;
    }
    
    //get address base on hash value.
    function getAddress(string _Hash) view external returns(address) {
        return Address;
    }
    
    
}