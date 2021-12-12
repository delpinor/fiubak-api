# language: es

Característica: US034 - DNI único al registrarse
Como usuario quiero que me indiquen si existe un usuario con mi DNI al registrarme

  Escenario: DNI existente
    Dado Ya esta registrado el usuario de nombre "Juan", dni "40226864" y email "juanopizzi@gmail.com"
    Cuando me registro con con nombre "Lucas", dni "40226864" y email "lucas@gmail.com"
    Entonces recibo un mensaje de error "El número de DNI ya está registrado."
