# language: es
@wip
Característica: US31.2 - Error al aceptar cotización de auto inexistente
Como usuario quiero que me indiquen con un error si la intención de venta no existe al aceptar cotización

  Antecedentes:
    Dado que no existen autos registrados

  Escenario: Error al aceptar cotización de auto inexistente
    Dado que soy usuario vendedor
    Cuando intento aceptarla cotización de id -1 de Fiubak
    Entonces recibo un mensaje de error "Cotizacion de auto inexistente."
