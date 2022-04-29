
/* Nuestro primer contrato sera una faucet de ethreum, recomiendo ampliamente no usar fondos de mainent, pues estos pueden 
    llegar a perderse, utilizar siempre redes de prueba para el aprendizaje y cuando este todo listo hacer el deploy en 
    mainet no antes.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; //la versión del compilador  de solidity que usaremos es el 0.8.6
/*
   Utilizamos la palabra reservada contract para indicar que vamos a crear un contrato seguido del nombre, todo lo que esté
    entre las llaves ({}) serán parte de este contrato
*/
contract Faucet {

    /* utilizamos la palabra reservada function para indicar que crearemos una función, después ponemos el nombre de la 
       misma  y seguido de esta el tipo de dato que recibe en este caso un entero sin signo (uint) el cual llamaremos 
       withdraw_amount, la función es de tipo public es decir que cualquier dirección/contrato puede interactuar con él.
    */
    function withdraw(uint withdraw_amount) public {
        // Le daremos la moneda pricipal de la red a cualquier dirección que interactue con nuestro contrato
        require(withdraw_amount <= 100000000000000000);/* es una función ya implementada que revisa si la condición,en este
                                                       caso withdraw_amount <= 100000000000000000 wei es cierta, si la
                                                       condición es cierta ejecuta el resto del código, si es falsa 
                                                       regresará un error y la transacción será revertida
                                                       */
        
        payable(msg.sender).transfer(withdraw_amount);/* aquí el contrato envía la cantidad requerida. msg representa la transacción
                                                que ejectutó el contrato, sender es la dirección de la wallet/contrato que 
                                                ejecutó la transacción, transfer es una función ya implementada que envía a eth
                                                de la dirección del contrato a la dirección que tiene sender, hacemos payable
                                                la dirección de quien ejecuta el contrato para poder enviarle eth
                                                */
        }
    
    /* Esta función es la llamada función predeterminada, que se llama si la transacción que desencadenó el contrato no 
    invocó ninguna de las funciones declaradas en el contrato,  o cualquier función en absoluto, o no contenía datos. 
    Los contratos pueden tener uno de esas función por defecto (sin nombre) y suele ser la que recibe ether. Por eso es
    que se define como una función pública y de pago, lo que significa que puede aceptar ether en el contrato. 
    No hace nada más que aceptar el éter, como lo indica la definición va´cia de la misma
    */
    fallback() external payable {}
}
