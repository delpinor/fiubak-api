# language: es
Característica: Como usuario vendedor quiero ver el estado de mis autos
    
    @wip
    Escenario: 1.1 – Consulta de estado exitosa
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Cuando consulto por mis autos registrados
    Entonces puedo ver mi auto con marca "fiat", modelo "uno", año 1988 y patente "asd-457" y estado "En Revision"