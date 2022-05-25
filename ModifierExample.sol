// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract ModifierExample{

    bool public myBoolean;
    string public myString;
    uint public myNumber;

    mapping(uint=> bool) public myMap;
    mapping(address=> uint) public myWallet;

    function setValue(uint index, bool value) public{
        myMap[index]=value;
    }

    function setMyAddress(address wallet, uint amount) public{
        myWallet[wallet]=amount;

    }
}