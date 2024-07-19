// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract OptiCoin {

    //Addresses with their balance, use mapping
    mapping(address => uint) balances;

    // ticker to name the coin
    bytes8 ticker = "OptiCoin";

    // Owner address
    address public owner;

    // Tokens minted
    uint mintedCoins = 0;

    // Limit for how many coins
    uint maxCoins = 210000;

    // Burnable to delete tokens of my own balance
    bool burnable = true;

    constructor(){
        owner = msg.sender;
    }

    function getBalance(address _owner) public view returns (uint) {
        return balances[_owner];
    }

    function mint(address _minter, uint _mintCoins) public{
        require(msg.sender == owner);
        require(mintedCoins < maxCoins, "There is no more coins to be minted");
        mintedCoins += _mintCoins;
        balances[_minter] += _mintCoins;
    }

    function send(address _sender, address _receiver, uint _coins) public {
        require(msg.sender == _sender);
        require(balances[_sender] >= _coins, "Not enough founds in sender wallet");
        balances[_sender] -= _coins;
        balances[_receiver] += _coins;
    }

    function burn(address _owner, uint _coinsToBurn) public {
        require(burnable == true, "Not burnable coins");
        require(balances[_owner] > _coinsToBurn, "No enough founds to be burnt");
        balances[_owner] -= _coinsToBurn;
    }

}