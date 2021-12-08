# language: es

Característica: US020 - Oferta de comprador p2p
  Como usuario comprador quiero hacer una oferta por un auto publicado(p2p)

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200

  Escenario: 20.1 - Oferta exitosa por auto p2p
    Cuando hago una oferta por el auto publicado
    Entonces recibo un mensaje de que la oferta se generó correctamente
    Y el vendedor es capaz de visualizar las ofertas consultando su publicacion


  @local
  Escenario: 20.2 - Oferta exitosa por auto p2p con mail
    Cuando hago una oferta por el auto publicado
    Entonces recibo un mensaje de que la oferta se generó correctamente
    Y recibo un email con la información de la oferta
  
  @local
  Escenario: 20.3 - Oferta exitosa por auto p2p
    Cuando alguien no registrado me hace una oferta
    Entonces recibo un mensaje "Para realizar esta operacion debe registrarse"
