// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract EventTest{

    address private owner;
    event tokenSent(address from, address to, uint amount);
    mapping (address=>uint) public tokenBalance;

    constructor(){
        tokenBalance[msg.sender]=100;
    }

    function sentToken(address to, uint amount)public returns (bool){
        require(msg.sender == owner,"no eres el owner");
        tokenBalance[msg.sender]-=amount;
        tokenBalance[to]+=amount;

        emit tokenSent(msg.sender,to,amount);

        return true;

    }

}
