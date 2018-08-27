RSpec.describe EasyCfdi::Comprobante do
  before(:all) do
    cert = EasyCfdi::ObtenerCertificado.new(File.read('spec/certificados/lan7008173r5.cer'))
    pem = OpenSSL::PKey::RSA.new File.read("spec/certificados/key.pem")

    @comprobante = EasyCfdi::Comprobante.new(
      certificado: cert,
      llave_pem: pem
    )
    @comprobante.encabezado = genera_encabezado_helper
    @comprobante.emisor = genera_emisor_helper
    @comprobante.receptor = genera_receptor_helper
  end      
  
  
  it "Debe generar un XML" do
    puts @comprobante.construye_xml
  end
end