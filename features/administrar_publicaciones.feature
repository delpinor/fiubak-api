# language: es

Característica: US033 - Administrar solo mis publicaciones/autos
Como usuario vendedor quiero administrar solo mis publicaciones/autos

  Antecedentes:
    Dado existe otro usuario registrado
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"

  Escenario: 33.1 - Consultar estado
    Dado que registro mi usuario
    Cuando consulto el estado por la intención de venta
    Entonces recibo un mensaje de error "No existe intención de venta asociada a su usuario"

  Escenario: 33.2 - Aceptar cotización
    Dado que registro mi usuario
    Y se recibe una revision sin fallas
    Cuando acepto la cotización
    Entonces recibo un mensaje de error "No existe intención de venta asociada a su usuario"

  Escenario: 33.3 - Rechazar cotización
    Dado que registro mi usuario
    Y se realizó la revisión sin fallas con precio de lista 100
    Cuando yo rechazo la cotización de Fiubak y publico por p2p con precio 300
    Entonces recibo un mensaje de error "No existe intención de venta asociada a su usuario"

  Escenario: 33.4 - Consultar publicación
    Dado que registro mi usuario
    Y se recibe una revision sin fallas
    Y que existe una publicación p2p del auto del otro usuario
    Cuando consulto la publicación de ese usuario
    Entonces recibo un mensaje de error "No existe publicación asociada a su usuario"

  Escenario: 33.5 - aceptar oferta
    Dado que registro mi usuario
    Y se recibe una revision sin fallas
    Y que existe una publicación p2p del auto del otro usuario
    Y que dicha publicación recibe una oferta
    Cuando intento aceptar la oferta
    Entonces recibo un mensaje de error "No existe oferta asociada a una publicación vigente para su usuario"

  Escenario: 33.6 - rechazar oferta
    Dado que registro mi usuario
    Y se recibe una revision sin fallas
    Y que existe una publicación p2p del auto del otro usuario
    Y que dicha publicación recibe una oferta
    Cuando intento rechazar la oferta
    Entonces recibo un mensaje de error "No existe oferta asociada a una publicación vigente para su usuario"

  Escenario: 33.7 - registrar autos ajenos
    Dado que registro mi usuario
    Cuando registro un auto de otro usuario
    Entonces recibo un mensaje de error "No hay dicha intencion de venta para su usuario"
