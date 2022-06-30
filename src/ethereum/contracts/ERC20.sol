// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {

    mapping(address => uint256) private _balances; //cada usuario cuantos tokens tiene?
    mapping(address => mapping(address => uint256)) private _allowances; //

    uint256 private _totalSupply; //el total de tokens

    string private _name;//nombre token
    string private _symbol;//simbolo token

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view override returns (string memory) { //retorna el nombre del token?
        return _name;
    }

    function symbol() public view override returns (string memory) { //retorna el simbolo del token
        return _symbol;
    }

    function decimals() public view override returns (uint8) { //18 decimales
        return 18;
    }

    //event Transfer(address indexed from, address indexed to, uint256 value);
    //event Approval(address indexed owner, address indexed spender, uint256 value)


    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) { //balance de alguen
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public override returns (bool) { //enviar tokens a una direccion
        address owner = msg.sender;
        _transfer(owner, to, amount);//funcion interna
        return true;
    }

    function allowance(address owner, address spender) public view override  returns (uint256) {//cuantos tokens he asignado a x wallet
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);//funcion interna
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) { //allowance...
        address spender = msg.sender;//OJITO ESTA FUNCION
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
}