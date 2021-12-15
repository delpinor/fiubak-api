# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module PublicacionesHelper
      def publicacion_a_hash(publicacion, id_intencion)
        {
          id_publicacion: publicacion.id,
          precio: publicacion.precio,
          id_intencion_de_venta: id_intencion
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
