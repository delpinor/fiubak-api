# language: es

Característica: US027 - Contratacion de test-drive
  Como usuario comprador quiero contratar un test-drive para definir mi intención de compra

  Antecedentes:
    Dado que existe una publicación de Fiubak con valor 1500
    Y existe una publicacion p2p con valor 1000

  @local
  Escenario: 27.1 - Test drive exitoso en un dia sin lluvia
    Cuando solicito el test-drive en un dia sin lluvia
    Entonces obtengo un mensaje "Test-drive para el día de hoy contratado con éxito. Deberá abonar una suma de $15"
    Y recibo un email confirmando la reserva de test-drive

  Escenario: 27.2 - Test drive exitoso en un día con lluvia  
    Cuando solicito el test-drive en un dia con lluvia
    Entonces obtengo un mensaje "Test-drive para el día de hoy contratado con éxito. Deberá abonar una suma de $12"

  Escenario: 27.3 - Test drive fallido por publicacion de tipo p2p
    Cuando solicito el test-drive en un dia con lluvia de una publicacion p2p
    Entonces obtengo un mensaje "Solo puede contratar test-drive para autos de Fiubak"

  Escenario: 27.4 - Test drive fallido por test-drive ya existente
    Cuando solicito el test-drive en un dia sin lluvia
    Y solicito el test-drive en un dia sin lluvia
    Entonces obtengo un mensaje "Contratacion fallida: Ya existe un test-drive asociado al dia de hoy"
