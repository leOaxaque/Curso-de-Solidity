// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 

contract owned {

    address payable owner;
    constructor(){
        owner = payable(msg.sender);
    }
    
    modifier onlyOwner {
        require(msg.sender == owner,"Only the contract owner can call this function");
        _;
    }
}

contract destruction is owned {
    function destroy() public onlyOwner {    
        selfdestruct(owner);
    }
}

contract faucet is destruction {
    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed to, uint amount);
    
    function withdraw(uint withdraw_amount) public {
        
        require(withdraw_amount <= 100000000000000000);
        
        require(address(this).balance >= withdraw_amount,"Insufficient balance in faucet for withdrawal request");
        
        payable(msg.sender).transfer(withdraw_amount);
        
        emit Withdrawal(msg.sender, withdraw_amount);
    }
    
    constructor() payable{//agregamos un constructor al contrato faucet y lo hacemos payable de modo que podamos crear y depositar fondos
                          // al contrato en una misma transaccion

    }
    fallback() external payable {
        emit Deposit(msg.sender,msg.value);
    }
}
