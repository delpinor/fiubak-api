# language: es
Característica: US015 - Publicar mi auto a un precio en p2p
Como usuario vendedor quiero publicar mi auto a un precio que quiero para venta p2p (rechazando la oferta de Fiubak)

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100
  
  Escenario: Publicación por p2p
    Cuando rechazo la cotización de Fiubak y publico por p2p con precio 200
    Entonces veo el auto publicado con id correspondiente para venta a un valor de 200

