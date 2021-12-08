class EnviadorMails
  def notificar_revision(revision, intencion_de_venta)
    email = intencion_de_venta.usuario.email
    patente = intencion_de_venta.auto.patente
    precio = revision.valor_cotizado

    enviar_mail(email, 'Cotización', cuerpo_cotizacion(intencion_de_venta.id, patente, precio))
  end

  def notificar_venta_exitosa(intencion_de_venta)
    email = intencion_de_venta.usuario.email
    patente = intencion_de_venta.auto.patente

    enviar_mail(email, 'Venta exitosa', cuerpo_venta_exitosa(intencion_de_venta.id, patente))
  end

  def notificar_oferta(publicacion, oferta, usuario_ofertador)
    email = publicacion.usuario.email

    enviar_mail(email, 'Oferta Recibida', cuerpo_oferta(publicacion.id, oferta.id, oferta.valor, usuario_ofertador.id))
  end

  def notificar_rechazo(id_oferta, auto, precio, usuario)
    email = usuario.email

    enviar_mail(email, 'Oferta rechazada', cuerpo_rechazo(id_oferta, auto, precio))
  end

  def notificar_aceptacion(id_oferta, auto, precio, usuario)
    email = usuario.email

    enviar_mail(email, 'Oferta aceptada', cuerpo_aceptacion(id_oferta, auto, precio))
  end

  private

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

  def cuerpo_oferta(id_publicacion, id_oferta, precio, id_usuario)
    titulo = "FIUBAK\n\n"
    cuerpo = "Le notificamos que su publicación con id: #{id_publicacion} " + "\n" \
             "fue ofertada por un valor de pesos($): #{precio}" + "\n" \
             "por el usuario con id: #{id_usuario}" + "\n"

    pie = 'Si desea aceptar la oferta, en el bot debe ingresar:' + "\n" \
          "/aceptar_oferta #{id_oferta}" + "\n" + "\n"

    saludos = 'Saludos, ' + "\n" + "\n" \
              'Equipo FIUBAK'

    titulo + cuerpo + pie + saludos
  end


  def enviar_mail(email, asunto, cuerpo)
    WebTemplate::App.email(:from => 'nairobitp2@gmail.com',
                           :to => email,
                           :subject => asunto,
                           :body => cuerpo)
  end
end
