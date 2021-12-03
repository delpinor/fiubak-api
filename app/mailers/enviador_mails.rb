class EnviadorMails
    def notificar_revision(revision, intencion_de_venta)
        email = intencion_de_venta.usuario.email
        patente = intencion_de_venta.auto.patente
        precio = revision.valor_cotizado

        enviar_mail(email, 'revision recibida', cuerpo_cotizacion(intencion_de_venta.id, patente, precio))
    end

    private

    def cuerpo_cotizacion(id_intencion_de_venta, patente, precio)
        "Se registró la cotizacion de la intencion de venta con id: #{id_intencion_de_venta}, precio #{precio} para el auto con patente: #{patente}"
    end

    def enviar_mail(email, asunto, cuerpo)
        WebTemplate::App.email(:from => 'FIUBAK <no_reply@fiubak.com>',
        :to => email,
        :subject => asunto,
        :body => cuerpo)
    end
end