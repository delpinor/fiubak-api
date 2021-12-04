# language: es

  @wip
Característica: US015 - Publicar mi auto a un precio en p2p
Como usuario vendedor quiero publicar mi auto a un precio que quiero para venta p2p (rechazando la oferta de Fiubak)

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y el estado de mi auto sera ‘revisado y cotizado’
    Y la cotización del auto no fue rechazada

  Escenario: Publicación por p2p
    Dado que tengo un auto en estado "revisado y cotizado"
    Cuando rechazo la cotización de Fiubak
    Y consulto el estado de mis autos
    Entonces figura en estado "publicado"

