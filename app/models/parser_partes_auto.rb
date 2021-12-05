class ParserPartesAuto
  NIVEL_DANIO = {0 => SinDanio, 1 => DanioBajo, 2 => DanioMedio, 3 => DanioAlto}.freeze

  def json_a_parte_auto(parte, json_data)
    case parte
    when :motor
      ParteMotor.new(NIVEL_DANIO[json_data['nivel_danio_motor']].new)
    when :estetica
      ParteEstetica.new(NIVEL_DANIO[json_data['nivel_danio_estetica']].new)
    when :neumaticos
      ParteNeumaticos.new(NIVEL_DANIO[json_data['nivel_danio_neumaticos']].new)
    end
  end
end
