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

    function _transfer(address from, address to, uint256 amount) internal { //interna
        require(from != address(0), "ERC20: transfer from the zero address."); //si es diferente de address 0?
        require(to != address(0), "ERC20: transfer to the zero address.");//poner direcciones validas

        uint256 fromBalance = _balances[from]; //ver cuantos tokens tiene para si le alcanza
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance.");

    unchecked { //ahorrar
        _balances[from] = fromBalance - amount; //resatmos la cantidad
    }
        _balances[to] += amount;//sumamos
        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address.");
        require(spender != address(0), "ERC20: approve to the zero address.");

        _allowances[owner][spender] = amount; //mapping
        emit Approval(owner, spender, amount);//lanzar evento
    }

    function _spendAllowance(address owner, address spender, uint256 amount) internal {//gastar los tokens que le dio el otro
        uint256 currentAllowance = allowance(owner, spender); //sacamos cuanto tiene
        if(currentAllowance != type(uint256).max) { //cambiar esta parte(?)
            require(currentAllowance >= amount, "ERC20: insufficient allowance.");
        unchecked { //ahorrar costos de gas
            _approve(owner, spender, currentAllowance - amount); //rebajar su monto
        }
        }
    }

    function _mint(address account, uint256 amount) internal { //creacion de tokensy darle a una cuenta
        require(account != address(0), "ERC: mint to the zero address.");
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal { //destruccion de tokens
        require(account != address(0), "ERC20 burn from the zero address.");
        uint256 accountBalance = _balances[account]; //balance de la cuenta que quiere destruir
        require(accountBalance >= amount, "ERC20 burn amount exceeds balance."); //no puede destruir tokens que no tiene
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }

    function increaseTotalSupply(address account, uint256 amount) public {
        _mint(account, amount);
    }
}