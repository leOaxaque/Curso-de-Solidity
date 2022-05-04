#cargamos de la librería brownie las cosas que vamos a utilizar
from brownie import accounts, faucet, web3

def main():
    act = accounts[0]#brownie genera una red de pruebas local en la cual podemos ejecutar nuestros contratos
                     # además de proporcionarnos cuentas con eth, seleccionamos la primera de dichas
                     #cuentas como cuenta con la cual vamos a interactuar
    f = faucet.deploy({'from': act})#con faucet.deploy creamos el deploy de nuestro contrato
                                    # el argumento from nos dice de que cuenta hacemos el deploy

    print(f"Faucet at: {f.address}")#imprimimos la dirección del contrato que deployamos
    print(f"Balance:   {f.balance()}\n")#impirmimos el balance en wei de nuestro contrato
    
    print(f"Account:   {act.address}")#imprimimos la dirección de la que hicimos el deploy
    print(f"Balance:   {act.balance()}")#imprimimos el balance en wei de nuestra direccion
    print("")

    print("Transfer ether to Faucet:")
    act.transfer(f.address, "1 ether")#con el método transfer indicamos que vamos a hacer una transferencia
                                      #de eth a la cueta/contrato f.address y por la cantidad de 1 ether

    print(f"Faucet at: {f.address}")
    print(f"Balance:   {f.balance()}\n")
    
    print(f"Account:   {act.address}")
    print(f"Balance:   {act.balance()}\n")
    

    print("withdraw from Faucet")
    #vamos a estimar la cantidad de ether que nos va a costar interactuar con nuestro contrato
    web3_f = web3.eth.contract(address=f.address, abi=f.abi)#con el método contract btendremos toda información que hay en la blockchain acerca de nuestro contrato
    estimated_gas = web3_f.functions.withdraw(web3.toWei(0.1, "ether")).estimateGas()#con esta función estimamos el gasto de ether que vamos a hacer por interactuar con el método withdraw
    print(f"Est. Gas:  {estimated_gas}\n")
    
    f.withdraw(web3.toWei(0.1, "ether"), {'from': act})#accedemos al método witdraw de la faucet para retirarle un monto
                                                      #con el método we3.toWei podemos transformar las cantidad de ethereum
                                                      #a wei para que sea más legible el código, from inidca la dirección que
                                                      #va a desplegar dicha transacción

    print(f"Faucet at: {f.address}")
    print(f"Balance:   {f.balance()}\n")
    
    print(f"Account:   {act.address}")
    print(f"Balance:   {act.balance()}")
