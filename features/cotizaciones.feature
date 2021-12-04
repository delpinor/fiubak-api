#language: es

Característica: US007 - Cotización con fallas de neumáticos

  Como usuario vendedor quiero recibir la cotización cuando tiene una falla de neumaticos

  Antecedentes:

    Dado que existe un auto en estado revision

  @local
  Escenario: 7.1 - Con fallas de neumaticos baja
    Y cuando termina la revision el estado tiene falla de neumaticos "baja" y precio de lista 1000
    Entonces el precio de la cotización es 970

  @local @wip
  Escenario: 7.2 - Con falla de neumaticos media
    Y cuando termina la revision el estado tiene falla de neumaticos "media" y precio de lista 1000
    Entonces el precio de la cotización es 920

  @local @wip
  Escenario: 7.3 - Con falla de neumaticos alta\
    Y cuando termina la revision el estado tiene falla de neumaticos "alta" y precio de lista 1000
    Entonces el precio de la cotización es 850
