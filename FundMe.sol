// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public addressToMountFunded; // muestra el monto envíado por la address actual    
    address[] funders;
    address payable owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    // modificadores
    modifier onlyOwner { // se asegura que la funcion que lo utiliza cumpla ciertos comportamientos o condiciones
        require(payable(msg.sender) == owner, "You are not the contract owner..."); // solo el propietario del contrato realizar tal función
        _; // ejecuta el resto del código de la función que lo utiliza
    }
    
    modifier checkBalance {
        require(address(this).balance > 0, "Not enough balance...");
        _;
    }
    

    // ENVIAR ACTIVOS AL CONTRATO
    function fund() public payable {        
        uint256 minWEIs = 20 * 10 ** 18; // minimo fondeo: 20 dolares en WEIs
        require(getConversionRate(msg.value) >= minWEIs, "Tiene que fondear mas dolares: minimo 20");
        addressToMountFunded[msg.sender] += msg.value; // agregar al mapping 'address->monto'
        funders.push(msg.sender); // agregar address al array de fondeadores
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); // ETH-USD
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256) { // view es para consultar a la blockchain
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); // traer el precio de ETH.USD desde el Oraculo
        (,int price,,,) = priceFeed.latestRoundData(); // 'destructuracion' del precio en ETH
        return uint256(price * 10000000000); // obtener el precio en WEIs
    }

    function getConversionRate(uint256 _ethAmount) public view returns(uint256){ // obtener el precio en USD
        uint256 ethPriceInWEIs = getPrice(); 
        uint256 ethAmountInUSD = (ethPriceInWEIs * _ethAmount) / 1000000000000000000;
        return ethAmountInUSD;
    } 

    // RETIRAR ACTIVOS DEL CONTRATO
    function withdraw() public payable onlyOwner checkBalance {         
        owner.transfer(address(this).balance); // transferir al propietario del contrato el balance del contrato 
    } 
}

// 99.820319520769000000