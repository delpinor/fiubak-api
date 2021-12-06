# language: es

Característica: US31.2 - Error al aceptar cotización de auto inexistente
Como usuario quiero que me indiquen con un error si la intención de venta no existe al aceptar cotización

Antecedentes:
  Dado que no existen autos registrados
  @wip
Escenario: Al aceptar cotización
  Dado registro un auto que está en etapa de cotizado y revisado
  Y que conozco su numero de intención de venta
  Cuando Cuando intento aceptarla cotización de Fiubak con otro numero
  Entonces recibo un mensaje de error "Intención de venta inexistente."
