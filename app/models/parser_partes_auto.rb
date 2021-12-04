class ParserPartesAuto
  NIVEL_DANIO = {'sin danio' => SinDanio}.freeze

  def json_a_parte_auto(parte, json_data)
    if parte == :motor
      ParteMotor.new(NIVEL_DANIO[json_data['estado_motor']].new)
    elsif parte == :estetica
      ParteEstetica.new(NIVEL_DANIO[json_data['estado_estetica']].new)
    elsif parte == :neumaticos
      ParteNeumaticos.new(NIVEL_DANIO[json_data['estado_estetica']].new)
    end
  end
end
