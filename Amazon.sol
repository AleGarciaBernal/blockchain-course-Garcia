// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Amazon{

    address private ownerAddress;

    constructor(){
        ownerAddress=msg.sender;
    }

    struct Product{
        string name;
        uint id;
        uint stock;
        uint price;

    }

    mapping(string=>Product) public inventario;

    //1) Solo el dueño de la tienda puede adicionar nuevos productos, un producto debe crearse con cantidad igual a
    //  cero, controlar internamente
    //2) Al crear un producto el dueño debe ingresar un nombre con longitud mayor a 5 de forma obligatoria

    function addProduct(Product memory newProduct, string memory newName, uint newStock)public{
        require(msg.sender==ownerAddress, "Debe ser el owner para agregar productos");
        require(newStock==0, "Debe tener 0 de stock");
        require(bytes(newName).length>5, "Nombre debe tener 5 chars");
        inventario[newName]=newProduct;
    }

}
