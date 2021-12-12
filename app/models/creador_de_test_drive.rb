class CreadorTestDrive
  def initialize
    @repo = Persistence::Repositories::RepositorioDeTestDrives.new
  end

  def crear_test_drive(publicacion)
    test_drive = TestDrive.new(publicacion, Date.today)
    validar_test_drive(test_drive)
    test_drive_con_id = @repo.save(test_drive)
    test_drive_con_id
  end

  def validar_test_drive(test_drive)
    raise TestDriveExistenteEnFecha.new if @repo.chequear_por_publicacion_y_fecha(test_drive.publicacion.id, test_drive.fecha)
    raise TipoInvalidoError.new if test_drive.publicacion.tipo != 'Fiubak'
  end
end
