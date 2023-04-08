// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

import "./SuperContract.sol";

// Crear una fabrica de SuperContract
contract SuperContractFactory{

    SuperContract[] public superContractArray;

    function createSuperContract() public {
        SuperContract superContract = new SuperContract();
        superContractArray.push(superContract);
    }

    function scfStorage(uint256 _indexContract, uint256 _contractNumber) public {
        SuperContract superContract = superContractArray[_indexContract]; // trae un contrato de la factoria
        superContract.store(_contractNumber); // almacena el numero del contrato
    }

    function scfGet(uint256 _numberContract) public {
        SuperContract superContract =
        superContract.retrieve(_numberContract);
    }

}
