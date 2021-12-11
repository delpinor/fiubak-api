# language: es

Característica: US035 - Como usuario quiero que mi email sea único al registrarme

  Escenario: 1 – Registro mail duplicado
    Dado Ya esta registrado el usuario de nombre "Juan", dni "40226864" y email "juanopizzi@gmail.com"
    Cuando me registro con con nombre "Lucas", dni "40204567" y email "juanopizzi@gmail.com"
    Entonces recibo un mensaje de error "El email ya se encuentra registrado"

  Escenario: 2 - Registro mail duplicado con diferencia de letras capitales
    Dado Ya esta registrado el usuario de nombre "Juan", dni "40226864" y email "juanopizzi@gmail.com"
    Cuando me registro con con nombre "Lucas", dni "40204567" y email "JuanOpizzi@gmail.com"
    Entonces recibo un mensaje de error "El email ya se encuentra registrado"
