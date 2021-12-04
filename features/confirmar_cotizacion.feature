# language: es

Característica: US006 - Confirmar cotizacion
  Como usuario vendedor quiero que me notifiquen por la cotizacion de mi auto para seguir el proceso de venta

  @local
  Escenario: 6.1 - Cotización de mi auto
    Dado que soy usuario vendedor
    Cuando registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Cuando se recibe una revision sin fallas
    Entonces recibo un mail con la cotizacion por mi auto
    Y el estado de mi auto sera ‘revisado y cotizado’
