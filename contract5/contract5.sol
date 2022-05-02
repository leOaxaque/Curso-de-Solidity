/* Actualización del contrato de Faucet, ahora agregaremos events, los cuales nos permitiran ver eventos específicos
y reportarlos, esto es muy útil cuando estamos haciendo DApps 
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6; 

contract owned {

    address payable owner;
    constructor() {
        owner = payable(msg.sender);
    }
    
    modifier onlyOwner {
        require(msg.sender == owner,"Only the contract owner can call this function");//el texto que le pasamos lo va a regresar
                                                                                    // en caso de que exista un error en la ejecución
        _;
    }
}

contract destruction is owned {
    function destroy() public onlyOwner {    
        selfdestruct(owner);
    }
}

contract faucet4 is destruction {
    event Withdrawal(address indexed to, uint amount);/*Los objetos event toman argumentos que se serializan y registran en 
                                                       los registros de transacciones, en la blockchain. Usamos la palabra 
                                                       clave indexed antes de un argumento, para que el valor forme parte de 
                                                       una tabla indexada (tabla hash) que una aplicación puede buscar o 
                                                       filtrar.*/
    event Deposit(address indexed to, uint amount);
    
    function withdraw(uint withdraw_amount) public {
        
        require(withdraw_amount <= 100000000000000000);
        // con address(this).balance hacemos mención al balance en ethereum que tiene este contrato, así podemos checar si 
        // es posible atender el withdraw o revetimos la transacción
        require(address(this).balance >= withdraw_amount,"Insufficient balance in faucet for withdrawal request");
        
        payable(msg.sender).transfer(withdraw_amount);
        
        emit Withdrawal(msg.sender, withdraw_amount); // con la palabra reservada emit agregamos la información del evento 
                                                     // Witdrawal, el cual requiere de la dirección y de la cantidad
    }
    
    
    fallback() external payable {
        emit Deposit(msg.sender,msg.value);
    }
}
