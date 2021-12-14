# language: es

Característica: US009 - Confirmación de venta a Fiubak
  Como usuario quiero aceptar la cotización de Fiubak para vender el auto
  Antecedentes:
    Dado que soy usuario vendedor
    Y registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Y se recibe una revision sin fallas
    Y el estado de mi auto sera ‘revisado y cotizado’
    Y la cotización del auto no fue rechazada
  Escenario: Figura como vendido
    Cuando acepto la cotización de Fiubak
    Y consulto el estado de mis autos
    Entonces figura en estado "vendido"
