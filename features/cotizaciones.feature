#language: es

Característica: US007 - Cotización con daño de neumáticos

  Como usuario vendedor quiero recibir la cotización cuando tiene daño de neumaticos

  Antecedentes:

    Dado que existe un auto en estado revision

  @local
  Escenario: 7.1 - Con daño de neumaticos bajo
    Y cuando termina la revision el estado tiene falla de neumaticos "bajo" y precio de lista 1000
    Entonces el precio de la cotización es 970

  @local
  Escenario: 7.2 - Con daño de neumaticos medio
    Y cuando termina la revision el estado tiene falla de neumaticos "medio" y precio de lista 1000
    Entonces el precio de la cotización es 920

  @local
  Escenario: 7.3 - Con daño de neumaticos alto
    Y cuando termina la revision el estado tiene falla de neumaticos "alto" y precio de lista 1000
    Entonces el precio de la cotización es 850
