module Helpers
  def genera_encabezado_helper
    EasyCfdi::Encabezado.new do |encabezado|
      encabezado.version = '3.3'
      encabezado.serie = 'F'
      encabezado.folio = Random.rand(1000)
      encabezado.forma_pago = '01'
      encabezado.tipo_de_comprobante = 'I'
      encabezado.metodo_pago = 'PUE'
      encabezado.lugar_expedicion = '09070'
    end
  end
  
  def genera_emisor_helper
    EasyCfdi::Emisor.new do |emisor|
      emisor.rfc = 'LAN7008173R5'
      emisor.nombre = 'Super Distribudora del Oriente SA de CV'
      emisor.regimen_fiscal = '601'
    end
  end
  
  def genera_receptor_helper
    EasyCfdi::Receptor.new do |receptor|
      receptor.rfc = 'XAXX010101000'
      receptor.nombre = 'Rodolfo Carranza Ramos'
      receptor.uso_cfdi = 'G03'
    end
  end
  
end