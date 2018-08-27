RSpec.describe EasyCfdi::ObtenerCertificado do
  cert = EasyCfdi::ObtenerCertificado.new(File.read('spec/certificados/lan7008173r5.cer'))

  it 'Instanciar el certificado' do
    expect(cert).to_not be(nil)
  end
  it 'Método numero_certificado debe contener la serie como lo pide el SAT' do
    expect(cert.numero_certificado).to eq '20001000000300022815'
  end
  it 'Método certificado debe retornar el string como lo pide el SAT' do
    expect(cert.certificado).to include('MIIFxTCCA62gAwIBAgIUMjAwMDEwMDAwMDAzMDAwMjI4MTUw')
    expect(cert.certificado).to_not include('-----BEGIN CERTIFICATE-----')
    expect(cert.certificado).to_not include('-----END CERTIFICATE-----')
  end
  it 'Método expires_at debe retornar la fecha de expiración en UTC' do
    expect(cert.expires_at.to_s).to include('2020-10-25 21:52:11 UTC')
  end
  it 'Método valid? debe retornar true si aún no expira' do
    expect(cert.valid?).to be(true)
  end
  it 'Método valid? debe retornar false si ya expiró' do
    expect(cert.valid?(cert.expires_at)).to be(false)
  end
end
