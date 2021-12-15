# language: es


Característica: US038 - Como usuario vendedor quiero que la patente sea única al registrar el auto


Escenario: 38.1 – Registro fallido de auto

  Dado que soy usuario vendedor
  Cuando registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
  Y registro un auto para vender con marca "fiat", modelo "dos", año 1989 y patente "asd-457" y espero mensaje
  Entonces obtengo un error de patente registrada