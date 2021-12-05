class NivelDanioHerlper
  ESTADOS = {'sin daño' => 0, 'bajo' => 1, 'medio' => 2, 'alto' => 3}
  def nivel_en_letra(nivel)
    ESTADOS[nivel]
  end
end
