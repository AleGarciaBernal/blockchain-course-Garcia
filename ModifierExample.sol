// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract ModifierExample{

    bool public myBoolean;
    string public myString;
    uint public myNumber;

    mapping(uint=> bool) public myMap;
    mapping(address=> uint) public myAddresses;

    function receiveMoney() public payable{
        myAddresses[msg.sender]+=msg.value;

    }

    function withdrawMoney(uint amount) public {
        uint amounttoEther=amount*(10**18);

        require(amounttoEther<=myAddresses[msg.sender],"Not enough money");
        myAddresses[msg.sender]-=amounttoEther;
        address MyWallet=msg.sender;
        payable(MyWallet).transfer(amounttoEther);


        // requiere(amount*(10**18)<= myAddresses[msg.sender], "No hay fondos suficientes"){
        //   myAddresses[msg.sender]-=amount*(10**18);
        // address MyWallet=msg.sender;
        //payable(MyWallet).transfer(amount*(10**18));
        //}

    }

    function setValue(uint index, bool value) public{
        myMap[index]=value;
    }

    function setMyAddress(address wallet, uint amount) public{
        myAddresses[wallet]=amount;

    }

}