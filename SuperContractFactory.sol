// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

import "./SuperContract.sol";

// Crear una fabrica de SuperContract
contract SuperContractFactory is SuperContract{

    SuperContract[] public superContractArray; // esto genera un boton de consulta

    // crea un contrato "superContract" y lo agrega a la factoria
    function createSuperContract() public {
        SuperContract superContract = new SuperContract();
        superContractArray.push(superContract);
    }

    // registra un numero a un contrato de la factoria
    function registerNumberToContract(uint256 _indexContract, uint256 _contractNumber) public {
        SuperContract(address(superContractArray[_indexContract])).registerNumber(_contractNumber); 
    }

    // devuelve el numbero de un contrato de la factoria
    function getContractNumber(uint256 _indexContract) public view returns(uint256){
        return SuperContract(address(superContractArray[_indexContract])).getNumber();        
    }

}
