# language: es
Característica: Como usuario vendedor quiero ver el estado de mis intenciones de venta
    
    Escenario: 1.1 – Consulta de estado exitosa
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457" y espero mensaje
    Cuando consulto por mis autos registrados
    Entonces puedo ver mi intencion de venta con id y estado "en revisión"

    Escenario: 1.2 – Consulta de estado de intencion de venta inexistente
    Dado que soy usuario vendedor
    Cuando consulto por el estado de la intención de venta con id -1
    Entonces recibo un mensaje de error "Intención de venta inexistente."
