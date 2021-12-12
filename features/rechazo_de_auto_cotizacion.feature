#language: es

Característica: US008 - Rechazo de auto por fallas

  Como usuario vendedor quiero saber si mi auto fue rechazado por fallas

  Antecedentes:
    Dado que existe un auto en estado revision

  Escenario: 8.1 - Con daño de neumaticos y estetica alto
    Y cuando termina la revision el estado tiene falla de neumaticos "alto" y falla de estetica "alto" y falla de motor "sin daño" y precio de lista 1000
    Entonces la cotizacion es rechazada
    Y el estado del auto es rechazado

  Escenario: 8.2 - Con daño de motor medio
    Y cuando termina la revision el estado tiene falla de neumaticos "sin daño" y falla de estetica "sin daño" y falla de motor "medio" y precio de lista 1000
    Entonces la cotizacion es rechazada
    Y el estado del auto es rechazado

  Escenario: 8.3 - Con daño de motor alto
    Y cuando termina la revision el estado tiene falla de neumaticos "sin daño" y falla de estetica "sin daño" y falla de motor "alto" y precio de lista 1000
    Entonces la cotizacion es rechazada
    Y el estado del auto es rechazado