# language: es

Característica: US015.1 - Publicar auto p2p con precio mayor a la cotización

Como usuario vendedor quiero publicar mi auto a un precio que quiero para venta p2p a un precio mayor al cotizado

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100
  
  Escenario: US015.1.1 - Con precio mayor a la cotización
    Cuando rechazo la cotización de Fiubak y publico por p2p con precio 200
    Entonces veo el auto publicado con id correspondiente para venta a un valor de 200

  Escenario: US015.1.2 - Con precio menor a la cotización
    Cuando rechazo la cotización de Fiubak y publico por p2p con un precio de 99
    Entonces recibo un mensaje de error al crear la publicacion 'El precio de publicación debe ser mayor al de cotización'

  Escenario: US015.1.3 - Con precio igual a la cotización
    Cuando rechazo la cotización de Fiubak y publico por p2p con un precio de 100
    Entonces recibo un mensaje de error al crear la publicacion 'El precio de publicación debe ser mayor al de cotización'