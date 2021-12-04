#language: es

Característica: US30.1 - Error al vender sin registrarme

  Como usuario quiero que me indiquen que debo registrarme cuando intento vender por un auto sin registrarme

  @wip
  Escenario: al registrar un auto
    Dado que no soy un usuario registrado
    Cuando registro un auto para vender con marca "fiat", modelo "uno", año 1988 y patente "asd-457"
    Entonces recibo un mensaje de error "Para realizar esta operación debe registrarse"
