RSpec.describe EasyCfdi do
  it "has a version number" do
    expect(EasyCfdi::VERSION).not_to be nil
  end

  it "does something useful" do
    cert = EasyCfdi::ObtenerCertificado.new(File.read('spec/certificados/lan7008173r5.cer'))
    pem = OpenSSL::PKey::RSA.new File.read("spec/certificados/key.pem")

    comprobante = EasyCfdi::Comprobante.new(
      certificado: cert,
      llave_pem: pem
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

=begin
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

    #puts comprobante.construye_xml
    #puts comprobante.genera_sello
=end
    end
end
