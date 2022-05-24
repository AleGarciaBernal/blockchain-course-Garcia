
// SPDX-License-Identifier: GPL-3.0

// 0xb176B12226E9dc5D1fE53C78806dEF49643B3a40

pragma solidity  ^0.8.0;

contract Inbox2 {

    string public message;
    address private ownerAddress;

    constructor(string memory initialMessage) {
        ownerAddress = msg.sender;
        message = initialMessage;
    }

    function getMessage() public view onlyOwner(msg.sender) returns(string memory) {
        return message;
    }

    function setMessage(string memory newMessage) public onlyOwner(msg.sender) {
        message = newMessage;
    }

    modifier onlyOwner(address client){
        require(client == ownerAddress , "Debe ser el owner para modificar!!" );
        _;
    }

}