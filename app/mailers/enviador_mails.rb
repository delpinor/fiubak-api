class EnviadorMails
  def notificar_revision(revision, intencion_de_venta)
    email = intencion_de_venta.usuario.email
    patente = intencion_de_venta.auto.patente
    precio = revision.valor_cotizado

    enviar_mail(email, 'Cotización', cuerpo_cotizacion(intencion_de_venta.id, patente, precio))
  end

  def notificar_revision_desaprobada(intencion_de_venta)
    email = intencion_de_venta.usuario.email
    patente = intencion_de_venta.auto.patente

    enviar_mail(email, 'Revisión fallida', cuerpo_revision_fallida(intencion_de_venta.id, patente))
  end

  def notificar_venta_exitosa(intencion_de_venta)
    email = intencion_de_venta.usuario.email
    patente = intencion_de_venta.auto.patente

    enviar_mail(email, 'Venta exitosa', cuerpo_venta_exitosa(intencion_de_venta.id, patente))
  end

  def notificar_oferta(publicacion, oferta, usuario_ofertador)
    email = publicacion.usuario.email

    if publicacion.es_fiubak?
      enviar_mail(usuario_ofertador.email, 'Auto comprado', cuerpo_comprar_fiubak(publicacion.id, oferta.valor, usuario_ofertador.nombre))
    else
      enviar_mail(email, 'Oferta Recibida', cuerpo_oferta(publicacion.id, oferta.id, oferta.valor, usuario_ofertador.nombre))
    end
  end

  def notificar_rechazo(id_oferta, auto, precio, usuario)
    email = usuario.email

    enviar_mail(email, 'Oferta rechazada', cuerpo_rechazo(id_oferta, auto, precio))
  end

  def notificar_aceptacion(id_oferta, auto, precio, usuario)
    email = usuario.email

    enviar_mail(email, 'Oferta aceptada', cuerpo_aceptacion(id_oferta, auto, precio))
  end

  def notificar_test_drive(test_drive, precio)
    email = test_drive.publicacion.usuario.email
    nombre = test_drive.publicacion.usuario.nombre
    enviar_mail(email, 'Test drive contratado', cuerpo_test_drive(nombre, test_drive.publicacion.auto.marca, test_drive.publicacion.auto.modelo, precio))
  end

  private

  def cuerpo_test_drive(nombre_usuario, marca, modelo, precio)
    titulo = "FIUBAK\n\n"
    cuerpo = "Muchas gracias #{nombre_usuario} por confiar en nosotros." + "\n" \
              "La reserva de un test-drive para el auto:" + "\n" \
             "Marca: #{marca},  Patente: #{modelo} fue realizada con exito." + "\n" \
             "Recuerde que deberá abonar por la misma: #{precio}" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + saludos
  end

  def cuerpo_cotizacion(id_intencion_de_venta, patente, precio)
    titulo = "FIUBAK\n\n"
    cuerpo = 'Le enviamos el valor cotizado de su auto:' + "\n" \
             "Id. de venta: #{id_intencion_de_venta} " + "\n" \
             "Precio cotizado en pesos($): #{precio}" + "\n" \
             "Patente del auto cotizado: #{patente}" + "\n"

    pie = 'Si desea aceptar el valor cotizado, en el bot debe ingresar:' + "\n" \
          "/aceptar_cotizacion #{id_intencion_de_venta}" + "\n" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + pie + saludos
  end

  def cuerpo_revision_fallida(id_intencion_de_venta, patente)
    titulo = "FIUBAK\n\n"
    cuerpo = "Debido al mal estado de su auto con patente #{patente}" + "\n" \
             "la revision fue un fracaso y no sera tenido en cuenta por Fiubak" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + saludos
  end

  def cuerpo_rechazo(id_oferta, auto, precio)
    titulo = "FIUBAK\n\n"
    cuerpo = 'Le informamos que su oferta fue rechazada' + "\n" \
             "Id. de oferta: #{id_oferta} " + "\n" \
             "Precio de la oferta en pesos($): #{precio}" + "\n" \
             "Patente del auto publicado: #{auto.patente}" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + saludos
  end

  def cuerpo_aceptacion(id_oferta, auto, precio)
    titulo = "FIUBAK\n\n"
    cuerpo = 'Felicidades! Usted será poseedor de uno de nuestros autos. Le informamos que su oferta fue aceptada.' + "\n" \
             "Id. de oferta: #{id_oferta} " + "\n" \
             "Precio de la oferta en pesos($): #{precio}" + "\n" \
             "Patente del auto publicado: #{auto.patente}" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + saludos
  end


  def cuerpo_venta_exitosa(id_intencion_de_venta, patente)
    titulo = "FIUBAK\n\n"
    cuerpo = "Felicidades! Su auto con patente #{patente} fue vendido con exito" + "\n" \
             "Id. de venta: #{id_intencion_de_venta} " + "\n"

    pie = 'Si desea revisar la información de la misma, en el bot debe ingresar:' + "\n" \
          "/consultar_estado #{id_intencion_de_venta}" + "\n" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + pie + saludos
  end

  def cuerpo_oferta(id_publicacion, id_oferta, precio, usuario_nombre)
    titulo = "FIUBAK\n\n"
    cuerpo = "Le notificamos que su publicación con id: #{id_publicacion} " + "\n" \
             "fue ofertada por un valor de pesos($): #{precio}" + "\n" \
             "por el usuario de nombre: #{usuario_nombre}" + "\n"

    pie = 'Si desea aceptar la oferta, en el bot debe ingresar:' + "\n" \
          "/aceptar_oferta #{id_oferta}" + "\n" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + pie + saludos
  end

  def cuerpo_comprar_fiubak(id_publicacion, precio, usuario_nombre)
    titulo = "FIUBAK\n\n"

    cuerpo = "Felicidades, #{usuario_nombre}! Le notificamos que compro el auto de id: #{id_publicacion} " + "\n" \
             "adquirido por el precio de ($): #{precio}" + "\n" \
             "comprado a Fiubak" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + saludos
  end


  def enviar_mail(email, asunto, cuerpo)
    if ENV['MAIL'] == 'SI'
      WebTemplate::App.email(:from => ENV['SENDGRID_USER'],
                             :to => email,
                             :subject => asunto,
                             :body => cuerpo)
    end
  end
end
