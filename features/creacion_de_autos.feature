# language: es

Característica: US002 - Registro de auto para vender
  Como usuario vendedor quiero registrar un auto para vender con su marca, modelo, año y patente

  Escenario: 1.1 – Registro exitoso
  Dado que soy usuario vendedor
  Cuando registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
  Entonces el auto se carga exitosamente con estado ‘en revisión’
