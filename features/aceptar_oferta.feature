# language: es

Característica: US017 - Aceptar oferta de comprador
  Como usuario vendedor quiero aceptar una oferta p2p de mi auto publicado

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200

  @local
  Escenario: 18.1 - Oferta aceptada por usuario vendedor con notificacion
    Cuando hago una oferta por el auto publicado
    Y acepto la oferta
    Entonces envio un mail de compra concretada con exito
  
  @local
  Escenario: 18.2 - Oferta aceptada por usuario vendedor y baja de publicacion
    Cuando hago una oferta por el auto publicado
    Y acepto la oferta
    Entonces la publicacion no existe mas
  
  @local
  Escenario: 18.3 - Oferta aceptada por usuario vendedor y auto vendido
    Cuando hago una oferta por el auto publicado
    Y acepto la oferta
    Entonces el auto figura en estado "vendido"
