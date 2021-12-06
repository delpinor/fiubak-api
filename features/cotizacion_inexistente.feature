# language: es

Característica: US31.2 - Error al aceptar cotización de auto inexistente
Como usuario quiero que me indiquen con un error si la intención de venta no existe al aceptar cotización

  Escenario: Error al aceptar cotización de auto inexistente
    Dado que soy usuario vendedor
    Cuando intento aceptar la cotización de id -1 de Fiubak
    Entonces recibo un mensaje de error "Cotizacion de auto inexistente."
