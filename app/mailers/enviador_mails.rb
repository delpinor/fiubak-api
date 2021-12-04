class EnviadorMails
    def notificar_revision(revision, intencion_de_venta)
        email = intencion_de_venta.usuario.email
        patente = intencion_de_venta.auto.patente
        precio = revision.valor_cotizado

        enviar_mail(email, 'Cotización', cuerpo_cotizacion(intencion_de_venta.id, patente, precio))
    end

    private

    def cuerpo_cotizacion(id_intencion_de_venta, patente, precio)
      titulo = 'Cotización FIUBAK' + "\n" + "\n"
      cuerpo = 'A continuación le enviamos la cotización:' + "\n"
      "Id. de intención de venta: #{id_intencion_de_venta} " + "\n"
        "Precio cotizado en pesos($): #{precio}" + "\n"
        "Patente del auto cotizado: #{patente}" + "\n"

      pie = 'Si desea aceptar la cotización en el bot debe ingresar:' + "\n"
        "/aceptar_cotización #{id_intencion_de_venta}" + "\n" + "\n"

      saludos = 'Saludos, ' + "\n" + "\n"
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
