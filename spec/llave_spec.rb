RSpec.describe EasyCfdi::ObtenerLlave do
  pem = EasyCfdi::ObtenerLlave.new File.read("spec/certificados/key.pem")
  it 'Instanciar la llave en formato pem' do
    expect(pem).to_not be (nil)
  end
  it 'Debe retornar un error personalizado si el archivo cargado no es un PEM'
  #Instrucciones para convertir manualmente el .key a .pem
end
