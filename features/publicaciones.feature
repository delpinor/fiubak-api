# language: es

Característica: US010 - Publicacion de auto para venta por fiubak
  Como usuario vendedor de auto, cuando confirmo la venta del auto a fiubak entonces observo el auto publicado con el valor asignado por fiubak

  Escenario: 1.1 – Auto sin fallas publicado exitosamente
  Dado que soy usuario vendedor
  Y registro un auto para vender con marca 'Renault', modelo 'Kangoo', año 2015 y patente 'MBK200'
  Y se realizó la revisión sin fallas con precio de lista 50000
  Cuando acepto la cotización de Fiubak
  Entonces veo el auto publicado para venta a un valor de 75000
