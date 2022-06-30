// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract Main {

    ERC20 private _token;
    address private owner;
    address private contractAddress;

    constructor(){
        _token = new ERC20("KyberCoin","KC");
        owner = msg.sender;
        contractAddress = address(this);
    }

    function priceTokens(uint256 numTokens) public returns(uint256) { //definir precio
        return numTokens * 1 ether;
    }

    function buyTokens(address client, uint256 amount) public payable { //vender sell a quien y cuanto
        uint256 price = priceTokens(amount);//sacamos el precio dependiendo cuantos tokens quiere
        require(msg.value >= price, "debe pagar el precio corecto en ether"); //que pague el precio
        uint256 returnValue = msg.value - price; //
        payable(msg.sender).transfer(returnValue); //cambio
        _token.transfer(client, amount); //llamamos a transfer del erc20
    }

    function generetaTokens(uint256 amount) public { //modifier
        _token.increaseTotalSupply(contractAddress, amount);
    }

    function getContractAddress() public view returns(address) {//direccion del smart contract
        return contractAddress;
    }

    function balanceAccount(address account) public view returns(uint256) {
        return _token.balanceOf(account);
    }

    function getTotalSupply() public view returns(uint256) {
        return _token.totalSupply();
    }

}