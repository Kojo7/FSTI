pragma solidity^0.4.20;

contract Appendix2 {

    mapping(string => int) temperatures;
    address supplierAddress = 0x43439Cca7E74523262b2C757c874aa09969C1c9e;

    modifier onlySupplier() {
        require(tx.origin == supplierAddress);
        _;
    }

    constructor() public {
        temperatures["steel"] = 34;
        temperatures["plastic"] = 12;
        temperatures["wood"] = 6;
        uint penalty = 5;
        Account account = _accounts[0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76];
        account.balance = 100;
        Account account1 = _accounts[tx.origin];
        account1.balance = 100;
    }

    struct Account {
        address _addr;
        uint balance;
    }

    mapping (address => Account) _accounts;

    event sendPenaltyFail (
        string _message
    );

    event sendPenaltySuccess (
        string _message,
        uint penalty
    );

    function getBalance() public returns(uint) {
        return _accounts[tx.origin].balance;
    }

    function checkThreshold(string material, int your_temperature) public returns(uint) {
        int difference = your_temperature - temperatures[material];
        if(difference > 2 && difference <= 6) {
            return 10;
        }
        if(difference > 6 && difference <= 10) {
            return 20;
        }
        else {
            return 0;
        }
    }

    function sendPenalty(uint penalty) onlySupplier payable returns(bool){
        if (_accounts[tx.origin].balance > penalty) {
            _accounts[0x58a5727f2E956D3017C61135b7a9Ff56b5B22b76].balance += penalty;
            _accounts[tx.origin].balance -= penalty;
            emit sendPenaltySuccess('The penalty sent successfully', penalty);
            return true;
        }
        else {
            emit sendPenaltyFail('You do not have enough money');
            return false;
        }
    }
}
