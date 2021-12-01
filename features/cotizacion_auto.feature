# language: es

@wip
Característica: US002 - Cotizacion de auto para proceso de venta
  Como usuario vendedor quiero que me notifiquen por la cotizacion de mi auto para seguir el proceso de venta

  Escenario: 1.1 – Cotización de mi auto
    Dado que soy usuario vendedor
    Y que fiubak puede comprar el auto con marca 'Renault', modelo 'Kangoo', año 2015 a un precio de 50000
    Y que registré mi auto con marca 'Renault', modelo 'Kangoo', año 2015 y patente 'MBK200' para venta
    Cuando se realiza la revision sin fallas
    Entonces recibo un mail con la cotizacion 50000 por mi auto
    Y el estado de mi auto sera 'Revisado y Cotizado'
