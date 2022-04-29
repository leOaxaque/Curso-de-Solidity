
/* Actualización del contrato de faucet, presentamos los modifieren como método de control para ejecución de funciones en el
contrato
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 

contract Faucet {
    
    address payable owner;

    
    constructor(){
        owner=payable(msg.sender);
    }
    /*Los modifier son un tipo especial de fucniones que se utilizan para dar condiciones de ejecución a 
    algunas de las funciones en el contrato, el _; de la línea de abajo de require(...) será sustituido el el código
    de la función que tenga el modifier */
    modifier onlyOwner{
        require(msg.sender==owner);
        _;
    }

    //Esta función destruirá el acceso al contrato solo si cumple los requerimientos del modifier
    function destroy() public onlyOwner {
        
        selfdestruct(owner);
    }


    //Todo después de esta línea es exactamente igual a la versión previa
    function withdraw(uint withdraw_amount) public {
        
        require(withdraw_amount <= 100000000000000000);
        
        payable(msg.sender).transfer(withdraw_amount);
    }
    
    
    fallback() external payable {}
}
