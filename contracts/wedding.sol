// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//import "./PriceConverter.sol";

error NotOwner();

contract mainMatrimonio{
    struct persona {
        address conyuge;
        bool personaEnUnion;
        address addressEspera;
        string nombre;
        string apellido;
        string nacionalidad;
        string IdNo;
     }

    address public immutable i_owner; //variable fija para guardar cartera del creador del contrato
    mapping(address => persona) public _Persona;


     //almacena la cartera de la persona que desplego el contrato (creador de contrato)
    constructor() {
        i_owner = msg.sender;
    }
    //Fucion donde pones el address del conyuge y tu informacion
function matrimonio(address _conyuge, string memory _nombre, string memory _apellido, string memory _nacionalidad, string memory _IdNo) public payable returns (string memory) {
        
        require(msg.sender != _conyuge, "Tienen que ser direcciones diferentes");    //verifica si persona solicitando matrimionio y conyuge no son misma persona
        require(_Persona[_conyuge].personaEnUnion == false, "Persona a la que te quieres unir ya esta en union"); //verifica que conyugue no este en union con otra persona
        require(_Persona[msg.sender].personaEnUnion == false, "Ya estas en union con otra persona");//Verifica si soliticante no este ya en union con otra persona
        
        string memory mensaje;
        mensaje = "Registrado, en espera del Conyuge";
        _Persona[msg.sender].addressEspera = _conyuge;
        _Persona[msg.sender].nombre = _nombre;
        _Persona[msg.sender].apellido = _apellido;
        _Persona[msg.sender].nacionalidad = _nacionalidad;
        _Persona[msg.sender].IdNo = _IdNo;
             
        if (_Persona[_conyuge].addressEspera == msg.sender){
            
            _Persona[_conyuge].conyuge = msg.sender;
            _Persona[msg.sender].conyuge = _conyuge;
            _Persona[_conyuge].personaEnUnion = true;
            _Persona[msg.sender].personaEnUnion = true;
            
            _Persona[msg.sender].nombre = _nombre;
            _Persona[msg.sender].apellido = _apellido;
            _Persona[msg.sender].nacionalidad = _nacionalidad;
            _Persona[msg.sender].IdNo = _IdNo;
            
            mensaje = "Felicidades, estan en Union en el blockchain";

        }

        return mensaje;
    }

    function balanceEnContrato() public view returns(uint){
        require(msg.sender == i_owner, "No tienes permiso de ver balance");
        return address(this).balance;
    }

    function retirar() payable public {
        require(msg.sender == i_owner, "No tienes permiso para ejecutar funcion");
        payable(msg.sender).transfer(address(this).balance);
    }

    function divorcio() public{
            //coming soon
    }






}