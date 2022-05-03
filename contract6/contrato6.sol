/*En este contrato veremos como crear un contrato(contrato externo) que inicialice otro(contrato interno), como ocupar las funciones del
contrato interno. Este contato interno se carga desde un archivo .sol distinto a nuestro contrato externo, de modo que podemos documentar
y comparticionar mejor el código
*/

/*
NOTA:
    Para ejecutar el contrato debe enviarse, al hacer deploy con la cantidad de eth que se depositará de inicio en la faucet más fee al menos,
    caso contrario la transacción fallará
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 
import "contracts/faucet.sol";//con esta linea estamos cargando el archivo faucet.sol, en el cual se encuentra la instancia de nuesta faucet, 
                              //reemplazar la ruta por la correcta al ejecutar

contract Contenedor is destruction{
    faucet _faucet;//creamos una variable llamada _faucet la cual "contendrá" un contrato de tipo faucet de modo que podemos inicializar contratos
                   //dentro de otros contratos
    constructor()  payable {//el constructor de Contenedor y de faucet deben de ser payable, ambos, para que funcione
      _faucet=(new faucet){value:150}(); //con la palabra reservada new indicamos que se cree un contrato de tipo faucet y el identificador del mismo esté 
                                        //contenido en la variable _faucet, al agregar {value:cantidad} estamos inicializando la faucet con esa cantidad de 
                                        //eth, medio en wei
    }

    function fill_faucet(uint amount) public{
        /*Esta función nos permite transferir fondos desde este contrato a nuestro contrato faucet, de modo que podemos volver a ingresar dinero a la
        misma si es que fuese necesario
        */
        payable(address(_faucet)).transfer(amount);
    }

    function destruction_faucet() public onlyOwner{
        /*con esta función podemos utilizar la función dstroy de nuestra faucet a trves del contrato contenedor*/
        // Observe que cuando se hace el destroy de la faucet el eth que contenía se manda a la dirección del contrato de Contenedor
        _faucet.destroy();
    }

    function withdraw_faucet(uint withdraw_amount) public{
        _faucet.withdraw(withdraw_amount);
    }
    
}
