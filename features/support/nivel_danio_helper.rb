class NivelDanioHerlper
  ESTADOS = {'sin daño' => 0, 'baja' => 1, 'media' => 2, 'alta' => 3}
  def nivel_en_letra(nivel)
    ESTADOS[nivel]
  end
end
