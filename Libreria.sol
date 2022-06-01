// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Libreria{

    address private owner;

    constructor(){
        owner=msg.sender;
    }

    struct Book{
        string title;
        string author;
        uint id;
        bool available;
    }

    mapping(uint=>Book) public inventario;

    function addBook(Book memory newbook, uint id)public{
        inventario[id]=newbook;
    }
    function getInventario(uint id) public view returns(string memory, bool){
        return (inventario[id].title, inventario[id].available);

    }

    function getBalance()public view returns(uint){
        return address(this).balance;
    }

    function borrow(uint id)public {
        require(inventario[id].available, "El libro no esta disponible");
        inventario[id].available=false;
    }

    function devolver(uint id)public{
        require(!inventario[id].available, "EL libro ya ha sido devuelto");
        inventario[id].available=true;
    }


}
