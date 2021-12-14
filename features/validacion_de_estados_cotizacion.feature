# language: es


Característica: US040 - Validacion de estados al aceptar/rechazar cotizacion

  Como usuario vendedor quiero obtener una alerta al intentar operar con autos rechazados o publicados

  Antecedentes:

    Dado que existe un auto en estado revision

  Escenario: 8.1 - El auto ya estaba rechazado

    Y cuando termina la revision el estado tiene falla de neumaticos "alto" y falla de estetica "alto" y falla de motor "sin daño" y precio de lista 1000
    Y acepto la cotización de Fiubak del auto
    Entonces obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado

  Escenario: 8.2 - El auto ya se publico por fiubak e intento aceptar cotizacion de nuevo

    Y se realizó la revisión sin fallas con precio de lista 100
    Y acepto la cotización de Fiubak del auto
    Y acepto la cotización de Fiubak del auto
    Entonces obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado

  Escenario: 8.3 - El auto ya se publico por fiubak e intento rechazar cotizacion

    Y se realizó la revisión sin fallas con precio de lista 100
    Y acepto la cotización de Fiubak del auto
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200 final
    Entonces obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado

  Escenario: 8.4 - El auto ya se publico por p2p e intento aceptar cotizacion de nuevo

    Y se realizó la revisión sin fallas con precio de lista 100
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200 final
    Y acepto la cotización de Fiubak del auto
    Entonces obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado

  Escenario: 8.5 - El auto ya se publico por p2p e intento rechazar cotizacion

    Y se realizó la revisión sin fallas con precio de lista 100
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200
    Y rechazo la cotización de Fiubak y publico por p2p con precio 200 final
    Entonces obtengo un mensaje indicando que el auto no esta en condiciones de ser publicado