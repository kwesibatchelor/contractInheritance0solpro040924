// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Inheritance {
    address owner; // stores the address of the contract owner
    uint asset; // stores total asset value associated with contract
    bool demised;

    constructor() payable {
        owner = msg.sender;
        asset = msg.value;
        demised = false;
    }

    modifier theOwner {
        require ( msg.sender == owner );
        _;
    }

    modifier isDemised {
        require (demised == true);
        _;
    }

    address[] wallets;
    mapping (address => uint) inheritance;

    function addToWill(address wallet, uint _wei) public {
        wallets.push(wallet);
        inheritance[wallet] = _wei;
    }

    function assetPayments() private isDemised {
        for(uint i = 0; i < wallets.length; i++) {
            payable(wallets[i]).transfer(inheritance[wallets[i]]);
        }
    }

    function died() public {
        demised = true;

        assetPayments();
    }
}