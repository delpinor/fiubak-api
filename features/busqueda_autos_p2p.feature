# language: es

Característica: US019 - Buscar oferta de autos p2p
Como usuario comprador quiero buscar ofertas p2p para realizar una oferta

  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "Renault", modelo "Kangoo", año 2015 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100

  Escenario: Auto publicado en p2p

    Cuando rechazo la cotización de Fiubak y publico por p2p con precio 45000
    Y busco ofertas de auto p2p
    Entonces veo el auto "Renault" del anio 2015 de modelo "Kangoo" y tipo "p2p" publicado por p2p por 45000
