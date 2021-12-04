class EnviadorMails
  def notificar_revision(revision, intencion_de_venta)
    email = intencion_de_venta.usuario.email
    patente = intencion_de_venta.auto.patente
    precio = revision.valor_cotizado

    enviar_mail(email, 'Cotización', cuerpo_cotizacion(intencion_de_venta.id, patente, precio))
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

  def enviar_mail(email, asunto, cuerpo)
    WebTemplate::App.email(:from => 'nairobitp2@gmail.com',
                           :to => email,
                           :subject => asunto,
                           :body => cuerpo)
  end
end
