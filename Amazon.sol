// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Amazon{

    address private ownerAddress;
    bool closed;

    constructor(){
        ownerAddress=msg.sender;
    }

    struct Product{
        string name;
        uint id;
        uint stock;
        uint price; //precio en ethers

    }

    mapping(string=>Product) public inventario;

    //1) Solo el dueño de la tienda puede adicionar nuevos productos, un producto debe crearse con cantidad igual a
    //  cero, controlar internamente
    //2) Al crear un producto el dueño debe ingresar un nombre con longitud mayor a 5 de forma obligatoria

    function addProduct(Product memory newProduct, string memory newName, uint newStock)public onlyOpen{
        require(msg.sender==ownerAddress, "Debe ser el owner para agregar productos");
        require(newStock==0, "Debe tener 0 de stock");
        require(bytes(newName).length>5, "Nombre debe tener 5 chars");
        inventario[newName]=newProduct;
    }
    //3) Solo el dueño de la tienda puede aumentar la cantidad que tiene un producto

    function addQuantity(uint newQuantity, string memory name)public onlyOpen{
        require(msg.sender==ownerAddress, "Debe ser el owner para aumentar stock");
        inventario[name].stock=newQuantity;
    }

    //4) Solo el dueño puedo cerrar la tienda para que se bloquee todo tipo de acciones, por ejemplo comprar,
    // aumentar cantidad, adicionar producto, retirar ganancias, etc
    function closeStoreAndOpen()public{
        if(!closed){
            closed=true;
        }else{
            closed=false;
        }
    }

    modifier onlyOpen(){
        require(closed==false,"La tienda esta cerrada");
        _;
    }

    //5) Solo el dueño puede retirar el total ganado a su direccion de billetera

    function receiveMoney()public payable{
        require(msg.sender==ownerAddress, "Debe ser owner para usar");
        msg.value;
    }

    function getBalance()public view returns(uint){
        return address(this).balance;
    }

    //6) El cliente puede comprar de 1 a N productos (hacer el calculo correspondiente segun el precio unitario del
    //producto) controlar internamente en caso que no tenga el dinero suficiente, tambien si existe el stock suficiente
    //para comprar el producto

    function buyProduct(string memory name,uint cantidadAComprar) public payable onlyOpen{
        require(inventario[name].stock>=1, "Producto Fuera de stock");
        require(cantidadAComprar>=1, "No puedes comprar 0 producto");
        require(msg.value>=((inventario[name].price)*cantidadAComprar), "dinero insuficiente");
        require(msg.value!=((inventario[name].price)*cantidadAComprar), "dinero demas");
        inventario[name].stock=inventario[name].stock-cantidadAComprar;

    }

    //10) Crear un metodo que permita al cliente consultar los productos en amazon
    function getProduct(string memory nombre)public view returns(string memory, uint,uint,uint){
        return (inventario[nombre].name,inventario[nombre].price,inventario[nombre].stock,inventario[nombre].id);


    }

    //Deploy en Binance Smart change
    //0x50e97BeB805f3B40d38144a6FEDB9169D0A3a73E


}
