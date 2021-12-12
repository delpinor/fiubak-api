WebTemplate::App.controllers :publicaciones, :provides => [:json] do

  @@clima = ''

  post :create, :map => '/publicaciones/:id/test_drives' do
    begin
      token = (request.env['HTTP_BOT_TOKEN'] or request.env['BOT_TOKEN'])
      ValidadorDeToken.new.validar_para_bot(token)

      publicacion = repositorio_de_publicaciones.find(params[:id])
      test_drive = CreadorTestDrive.new.crear_test_drive(publicacion)
      nuevo_test_drive = repositorio_de_test_drives.save(test_drive)
      precio = nuevo_test_drive.obtener_costo(ProveedorDeClima.new(@@clima))
      #EnviadorMails.new.notificar_test_drive(publicacion, oferta, usuario)

      status 201
      {mensaje: "Test-drive para el día de hoy contratado con éxito. Deberá abonar una suma de $#{precio.round}"}.to_json
    rescue NoAutorizadoError
      status 401
      {mensaje: 'No autorizado'}.to_json
    rescue TestDriveExistenteEnFecha
      status 409
      {mensaje: 'Contratacion fallida: Ya existe un test-drive asociado al dia de hoy'}.to_json
    rescue PublicacionNoEncontradaError => e
      status 404
      {mensaje: 'La publicacion no existe'}.to_json
    end
  end

  post :create, :map => '/clima' do
    data = JSON.parse(request.body.read)
    @@clima = data['clima']
    status 200
    {mensaje: "Clima seteado con exito"}.to_json
  end
end
