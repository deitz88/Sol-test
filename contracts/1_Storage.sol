pragma solidity >=0.4.16 <0.9.0;
// SPDX-License-Identifier: MIT

contract Storage {
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns(uint) {
        return storedData;
    }
}
