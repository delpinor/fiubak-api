# language: es

Característica: US011 - Recibir email por venta a Fiubak
  Como usuario vendedor quiero recibir una notificación por email de venta exitosa a Fiubak

  @local
  Escenario: 11.1 - Aceptación de cotización
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se recibe una revision sin fallas
    Cuando acepto la cotización de Fiubak
    Entonces recibo un email con la información de compra
