pragma solidity^0.4.20;

contract Appendix3 {

    uint[] requirements;

    constructor(uint req1val, uint req2val) public {
        requirements.push(req1val) -1;
        requirements.push(req2val) -1;
    }

    function checkRequirements(uint req1, uint req2) external returns(bool) {
        if((requirements[0] < req1) && (requirements[1] > req2)) {
            return true;
        }
        else {
            return false;
        }
    }
}