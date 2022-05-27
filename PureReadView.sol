// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract PureViewRead{
    bool public myBoolean;
    string public myString;
    uint public myNumber;

    mapping(uint => bool) public myMapping;
    mapping(address => uint) public myAddresses;

    function setValue(uint _index, bool _value) public {
        myMapping[_index] = _value;
    }

    function setMyAddresses(address _wallet, uint balance) public {
        myAddresses[_wallet] = ethToWei(balance);
    }

    function receiveMoney() public payable{
        myAddresses[msg.sender] += msg.value;
    }

    function ethToWei(uint eth) public pure returns(uint){
        return eth * 1 ether;
    }

    function withdrawMoney(uint _amount) public {

        uint amountToEther = ethToWei(_amount);

        require(amountToEther <= myAddresses[msg.sender], "Insufficient funds");
        myAddresses[msg.sender] -= amountToEther;
        payable(msg.sender).transfer(amountToEther);

    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

}