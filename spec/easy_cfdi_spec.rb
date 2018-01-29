RSpec.describe EasyCfdi do
  it "has a version number" do
    expect(EasyCfdi::VERSION).not_to be nil
  end

  it "does something useful" do
    comprobante = EasyCfdi::Comprobante.new(
      certificado: './spec/certificados/lan7008173r5.cer',
      llave_pem: './spec/certificados/key.pem',
      autocalcular_totales_encabezado: true,
      autoescribir_nodo_impuestos: true
    )

    comprobante.encabezado = {
      Version: '3.3',
      Serie: 'F',
      Folio: 12345678,
      FormaPago: '01',
      TipoDeComprobante: 'I',
      MetodoPago: 'PUE',
      LugarExpedicion: '09070'
    }

    comprobante.emisor = {
      Rfc: 'LAN7008173R5',
      Nombre: 'Super Distribudora del Oriente SA de CV',
      RegimenFiscal: '601'
    }

    comprobante.receptor = {
      Rfc: 'XAXX010101000',
      Nombre: 'Rodolfo Carranza Ramos',
      UsoCFDI: 'G03'
    }

    puts comprobante.construye_xml
    puts comprobante.genera_sello
    end
end
