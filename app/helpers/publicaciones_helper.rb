# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module PublicacionesHelper
      def repositorio_de_publicaciones
        Persistence::Repositories::RepositorioDePublicaciones.new
      end

      def repositorio_de_ofertas
        Persistence::Repositories::RepositorioDeOfertas.new
      end

      def repositorio_de_intencion_de_ventas
        Persistence::Repositories::RepositorioDeIntencionesDeVenta.new
      end

      def publicar_p2p(data_json)
        data = JSON.parse(data_json)
        intencion_de_venta = repositorio_de_intencion_de_ventas.find(data['id_intencion_de_venta'])
        publicacion = intencion_de_venta.concretar_por_p2p(data['precio'])
        repositorio_de_intencion_de_ventas.save(intencion_de_venta)
        publicacion_creada = repositorio_de_publicaciones.save(publicacion)
        {
          id_publicacion: publicacion_creada.id,
          precio: publicacion_creada.precio,
          id_intencion_de_venta: intencion_de_venta.id
        }
      end

      def nueva_oferta_a_json(oferta)
        {
          mensaje: "Generaste la oferta #{oferta.id} con un monto de $#{oferta.valor}",
          valor: {
            id: oferta.id,
            valor: oferta.valor
          }
        }.to_json
      end

      def oferta_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def obtener_publicaciones
        publicaciones = repositorio_de_publicaciones.all
        { estado: intencion_de_venta.estado, id: intencion_de_venta.id }
      end

      def publicaciones_a_json(publicaciones)
        publicaciones.map { |publicacion| atributos_publicacion(publicacion) }.to_json
      end

      def publicacion_a_json(publicacion)
        {id: publicacion.id, marca: publicacion.auto.marca, modelo: publicacion.auto.modelo, patente: publicacion.auto.patente,
         anio: publicacion.auto.anio, precio: publicacion.precio, ofertas: publicacion.ofertas.map { |oferta| atributos_oferta(oferta) }}.to_json
      end

      def atributos_publicacion(publicacion)
        {id: publicacion.id, marca: publicacion.auto.marca, modelo: publicacion.auto.modelo, anio: publicacion.auto.anio, precio: publicacion.precio, tipo: publicacion.tipo}
      end

      def atributos_oferta(oferta)
        {id: oferta.id, valor: oferta.valor, nombre_comprador: oferta.usuario.nombre}
      end
    end

    helpers PublicacionesHelper
  end
end
