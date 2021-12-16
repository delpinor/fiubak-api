# language: es

Característica: US039 - Compra de autos publicados por Fiubak
Como usuario comprador quiero comprar un auto de Fiubak
  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se realizó la revisión sin fallas con precio de lista 100
    Y acepto la cotización de Fiubak
    Y veo el auto publicado para venta

  Escenario: 39.1 - Compra de auto a Fiubak

    Cuando hago una oferta por el auto publicado con el monto exacto
    Entonces recibo un mensaje "Compraste el auto"

  Escenario: 39.2 - Compra de auto a Fiubak fallida por monto

    Cuando hago una oferta por el auto publicado con un monto distinto
    Entonces recibo un mensaje de error "El monto debe ser igual al de la publicacion"

