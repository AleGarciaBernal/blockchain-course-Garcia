pragma solidity ^0.8.0;
// SPDX-License-Identifier: GPL-3.0


interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value); //evento de cuando se hace
    event Approval(address owner, address spender, uint256 value);

    function totalSupply() external view returns(uint256);//cuantos tokens existen????
    function balanceOf(address account) external view returns(uint256);//cuantos tokens tiene esa wallet
    function transfer(address to, uint256 amount) external returns(bool);//true si fue exitosa la transaccion
    function allowance(address owner, address spender) external view  returns(uint256);//permisos para gastar mis tokens, cuantos tokens le aurice
    function approve(address spender, uint256 amount) external returns(bool);//asignar tokens para que gaste mis tokens
    function transferFrom(address from, address to, uint256 amount) external returns(bool);//la wallet que me dio permisos, a quien y el monto



}