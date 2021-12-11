# language: es

@wip
Característica: US027 - Contratacion de test-drive
  Como usuario comprador quiero contratar un test-drive para definir mi intención de compra

  Antecedentes:
    Dado que existe una publicación de Fiubak con valor 1000
    Y existe una publicacion p2p

  Escenario: 27.1 - Test drive exitoso en un dia sin lluvia
    Cuando solicito el test-drive en un dia sin lluvia
    Entonces obtengo un mensaje "Usted confirmó la reserva de test-drive para el dia de hoy. El monto a pagar es $10"
    Y obtengo una notificacion por mail

  Escenario: 27.2 - Test drive exitoso en un día con lluvia  
    Cuando solicito el test-drive en un dia con lluvia
    Entonces obtengo un mensaje "Usted confirmó la reserva de test-drive para el dia de hoy. El monto a pagar es $8"

  Escenario: 27.3 - Test drive fallido por publicacion de tipo p2p
    Cuando solicito el test-drive en un dia con lluvia
    Entonces obtengo un mensaje "Solo puede contratar test-drive para autos de Fiubak"

  Escenario: 27.4 - Test drive fallido por test-drive ya existente
    Cuando solicito el test-drive en un dia sin lluvia
    Y solicito el test-drive en un dia sin lluvia
    Entonces obtengo un mensaje "Contratacion fallida: Ya existe un test-drive asociado al dia de hoy"
