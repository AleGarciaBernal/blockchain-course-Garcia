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
}