# language: es

@wip
Característica: US010 - Publicacion de auto para venta por fiubak
  Como usuario vendedor de auto, cuando confirmo la venta del auto a fiubak entonces observo el auto publicado con el valor asignado por fiubak

  Escenario: 1.1 – Auto sin fallas publicado exitosamente
  Dado que soy usuario vendedor
  Y que fiubak puede comprar el auto con marca 'Renault', modelo 'Kangoo', año 2015 a un precio de 50000
  Y registro un auto para vender con marca 'Renault', modelo 'Kangoo', año 2015 y patente 'MBK200'
  Y se realizó la revisión sin fallas
  Cuando acepto la cotización de Fiubak
  Entonces veo el auto publicado para venta a un valor de 75000
