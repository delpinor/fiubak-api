# language: es

  @wip
Característica: US019 - Buscar oferta de autos p2p
Como usuario comprador quiero buscar ofertas p2p para realizar una oferta

  Escenario: Auto publicado en p2p

    Dado que existe un auto publicado a un precio de 45623
    Y Dado que existe un auto publicado a un precio de 55236
    Cuando busco ofertas de auto p2p
    Entonces veo el auto publicado para venta a un valor de 45623
    Y veo el auto publicado para venta a un valor de 55236
