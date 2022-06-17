// SPDX-License-Identifier: GPL-3.0

//Usando Modifier

pragma solidity ^0.8.0; //poner la version de solidity que usaremos

contract Inbox2{

    string public message; //tipo, modificador de visibilidad, nombre
    address private ownerAddress;         //varibale de tipo billetera

    constructor(string memory initialMessage){
        ownerAddress=msg.sender;              //msg son variables globales que tiene el smart contract
        //Aqui guardamos quien es el owner al deployar
        //msg sender---> el que crea el smart contract? o llame a la funcion video 5
        message=initialMessage;
    }


    function getMessage()public onlyOwner (msg.sender)view returns(string memory){  //Usar memory para strings?, view para que no nos cobre al consultar
        return message;

    }

    function setMessage(string memory newMessage) public onlyOwner (msg.sender){     //Usar memory para strings?//Queremos restringir esta funcion
        // require(msg.sender==ownerAddress, "Debe ser el owner para modificar");
        message=newMessage;                                   //Usaremos un require
    }

    function getOwner()public view returns(address){
        return ownerAddress;
    }

    modifier onlyOwner(address client){ //para factorizar codigo
        require(ownerAddress==client, "Debe ser el owner para modificar");
        _;
    }

}

//require(1==2, "No SE PUDO");
//bytes(newMessage).length>10------>castear a bytes
//require(bytes(newMessage).length>10, "Debe tener de largo 10");

