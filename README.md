# EasyCfdi
[![Build Status](https://travis-ci.org/havilchis/easy_cfdi.svg?branch=master)](https://travis-ci.org/havilchis/easy_cfdi)

This is a Gem for build a valid XML file for the Mexican requirements of Digital Invoicing.

El propósito de ésta libreria es el siguiente:
 * Generar la estructura XML a partir de los parámetros recibidos.
 * Generar la Cadena Original e integrar el Sello y el Certificado al XML.
 * Validar la estructura y la sintaxis del XML utilizando como base el arhivo XSD proporcionado por el SAT para tal propósito.
 * Devolver un XML listo para enviar a cualquier PAC para su timbrado.   

Esta gema NO hace cálculos de impuestos o de subtotales. Sólo se encarga de mapear los datos que usted ingresa con la estructura válida del CFDI. Puede ingresar Strings, Numbers, Modelos de ActiveRecord o cualquier porción de código ruby. 
```ruby
    # ... fragmento de código ....
    # Es válido
    emisor.nombre = "Servicios Almaza SA de CV"
    # o también
    emisor.nombre = @user.name
    # y también...
    emisor.nombre = MyRandomClass.lo_que_sea(nombre)
```
Piense en que se trata de una especie de plantilla como haml o erb. 
Las únicas excepciones son la generación de los atributos *Sello*, *Certficado* y *NoCertificado*, los cuales sí se calculan en automático al momento de generar el XML.

## Atención: Proyecto en fase Alpha
Ésta Gema se encuentra en proceso de construcción, tanto el código como la documentación están incompletos. Este README se actualiza conforme se vallan creando funcionalidades.

## Requisitos

 - Ruby 2.3 en adelante (En desarrollo, el código se prueba con 2.3.0, 2.4.0 y 2.5.0). Debido a la dependecia con OpenSSL, de momento NO es compatible con Jruby.
 - OpenSSL instalado en su server. Puede verificar ejecutando el comando `$ openssl -v` directamente en la terminal.
 - Un juego de Certificado de sello Digital (CSD) vigente emitido por el SAT.
	 - Archivo .cer
	 - Archivo .key y su respectiva contraseña (Se requiere convertir a formato .pem, instrucciones más adelante).

### Convertir archivo .key a formato .PEM
Éste paso es requerido, pues no encontré la forma en que la gema pueda leer nativamente el archivo .key asignado por el SAT.
El procedimiento es muy sencillo, y se debe hacer en una PC que tenga OpenSSL instalado.
Abrir una terminal, ubicarse en la carpeta donde están los CSD y ejecutar:

	$ openssl pkcs8 -inform DET -in aaa010101aaa.key -passin pass:12345678a -out key.pem
Donde:
 - *aaa010101aaa.key* es nombre de tu llave.
 - *12345678a* es la contraseña de tu certificado.
 - *key.pem* es el nombre del archivo final ya convertido a PEM, y es el que se utilizará para generar la el sello del CFDI.

Usted podría crear un script (o un Backgroud Job)para realizar éste procedimiento en automático cada vez que un usuario suba sus certificados.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_cfdi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_cfdi

## Uso

Ejemplo básico, para más escenarios, revise la Wiki.

 1. Instanciar el certificado y la llave en formato PEM.
	 ```ruby
	 cert_file = File.read('path/to/certificate/RCF7008274R5.cer')
	 cert = EasyCfdi::ObtenerCertificado.new(cert_file)

	 pem_file = File.read("path/to/certificate/key.pem")
	 pem = EasyCfdi::ObtenerLlave.new(pem_file)
	 ```
2. Instanciar el comprobante, con la llave y el certificado como parámetros:
	```ruby
	comprobante = EasyCfdi::Comprobante.new(certificado: cert, llave_pem: pem)
	```
3. Construir los nodos y los atributos necesarios (Los nombres del los nodos son convertidos automaticamente a CammelCase al momento de generar el XML):
	```ruby
    @comprobante.encabezado = EasyCfdi::Encabezado.new do |encabezado|
      encabezado.version = '3.3'
      encabezado.serie = 'F'
      encabezado.folio = '45612'
      encabezado.forma_pago = '01'
      encabezado.tipo_de_comprobante = 'I'
      encabezado.metodo_pago = 'PUE'
      encabezado.lugar_expedicion = '09070'
    end
    comprobante.emisor = {
      Rfc: 'LAN7008173R5',
      Nombre: 'Super Distribudora del Oriente SA de CV',
      RegimenFiscal: '601'
    }
	```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/havilchis/easy_cfdi.

## License

Esta librería se libera "Open Source" bajo los términos de la licencia MIT:

Copyright (c) 2018 Hugo Armando Vilchis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
