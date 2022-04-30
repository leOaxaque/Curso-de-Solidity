/* Actualización del contrato de Faucet, veremos como podemos ocupar la herencia, es decir ocuapar
funcionalidades de otros contratos en el nuestro.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 

contract owned {
    /*Este contrato solo define el dueño de nuestros contrato y define el modifier onlyOwner, así no debemos 
    codificarlo en cada contrato que  escribamos*/
    address payable owner;
    constructor() {
        owner = payable(msg.sender);
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}
// al ocupar la palabra reservada is después del nombre del contrato indicamos que el contrato que definimos es hijo
// del contrato o contratos que referenciamos, de modo que pueden ocupar todas las funciones y variables que estén definidos
//en los mismo
contract destruction is owned {
    function destroy() public onlyOwner {    
        selfdestruct(owner);
    }
}

contract faucet3 is destruction {
    function withdraw(uint withdraw_amount) public {
        
        require(withdraw_amount <= 100000000000000000);
        
        payable(msg.sender).transfer(withdraw_amount);
    }
    
    
    fallback() external payable {}
}
