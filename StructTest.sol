// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract StructTest{

    struct Book{

        string title;
        string autor;
        uint id;
        bool available;
        uint quantity;

    }

    Book public book1;
    Book public book2=Book("SOy titulo", "GArcia", 154, true, 3);

    mapping(uint=>Book) libraryBook;

    function borrowBook(uint idBook)public{
        libraryBook[idBook].quantity--;

    }

    function isAvailable(uint idB)public view returns(bool){
        return libraryBook[idB].available;

    }

    function addBook(Book memory newBook)public {
        libraryBook [newBook.id]=newBook;

    }

    function getTitle()public view returns(string memory){
        return book1.title;

    }

    function setTitle()public{
        book1.title="my title";

    }

    function getTitleandID()public view returns(string memory, uint){
        return (book2.title, book2.id);

    }

}