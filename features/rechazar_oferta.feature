# language: es

Característica: US018 - Rechazar oferta de comprador
  Como usuario vendedor quiero rechazar una oferta por un auto propio publicado

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200

  @local
  Escenario: 18.1 - Oferta rechazada por usuario vendedor
    Cuando hago una oferta por el auto publicado
    Y rechazo la oferta
    Entonces envio un mail rechazando la oferta
