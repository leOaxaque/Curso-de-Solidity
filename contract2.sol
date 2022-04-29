
/* Actualización del contrato 1, agregaremos un constructor y un método de destrucción del contrato
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 

contract Faucet {
    //Definimos una dirección la cual será el dueño del contrato, de modo que podrermos tener funciones
    // que solo sean llamados por esta dirección, cosa que nos ayudará por ejemplo a retirar los fondos de la faucet
    address payable owner;

    //este es el constructor del contrato, este se ejecutará en cuanto se cree el contrato y solo una vez, su 
    //única acción es  asignar el owner del contrato a la dirección que lo desplegó
    constructor(){
        owner=payable(msg.sender);//le hacemos un cast a la función solo para que encaje con el tipo que debe de ser owner
    }

    //Esta función destruirá el acceso al contrato
    function destroy() public {
        require(msg.sender == owner);
        selfdestruct(owner);//para que se pueda ejecutar owner debe ser un adress payable y le envía lo que queda de eth a
                            // la dirección en este caso owner
    }


    //Todo después de esta línea es exactamente igual a la versión previa
    function withdraw(uint withdraw_amount) public {
        
        require(withdraw_amount <= 100000000000000000);
        
        payable(msg.sender).transfer(withdraw_amount);
    }
    
    
    fallback() external payable {}
}
