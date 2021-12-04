class ParserPartesAuto
  NIVEL_DANIO = {'sin danio' => SinDanio, 'danio bajo' => DanioBajo}.freeze

  def json_a_parte_auto(parte, json_data)
    case parte
    when :motor
      ParteMotor.new(NIVEL_DANIO[json_data['estado_motor']].new)
    when :estetica
      ParteEstetica.new(NIVEL_DANIO[json_data['estado_estetica']].new)
    when :neumaticos
      ParteNeumaticos.new(NIVEL_DANIO[json_data['estado_neumaticos']].new)
    end
  end
end
