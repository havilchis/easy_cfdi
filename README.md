# EasyCfdi
[![Build Status](https://travis-ci.org/havilchis/easy_cfdi.svg?branch=master)](https://travis-ci.org/havilchis/easy_cfdi)

This is a Gem for build a valid XML file for the Mexican requirements of Digital Invoicing.

El propósito de ésta libreria es el siguiente:
 * Generar la estructura XML a partir de los parámetros recibidos.
 * Generar la Cadena Original y Sello. Agregarlos junto con el Certificado al cuerpo del XML.
 * Validar la estructura y la sintaxis del documento utilizando como base el arhivo XSD proporcionado por el SAT para tal propósito.
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
Ésta Gema se encuentra en proceso de construcción, tanto el código como la documentación no están listos para funcionar. 
Este README se actualiza conforme se vallan creando funcionalidades.

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
 - *aaa010101aaa.key* es el nombre de la llave.
 - *12345678a* es la contraseña del certificado.
 - *key.pem* es el nombre del archivo final ya convertido a PEM, y es el que se utilizará para generar la el sello del CFDI.

Usted podría crear un script (o un Backgroud Job) para realizar éste procedimiento en automático cada vez que un usuario suba sus certificados.



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

Ejemplo básico, más adelánte se creará una carpeta "examples" para documentar más escenarios.

```ruby
# Leer el contenido de los certificados del SAT.
cert_file = File.read('path/to/certificate/RCF7008274R5.cer')
pem_file = File.read("path/to/certificate/key.pem")

# Instanciar los certificados en objetos.
cert = EasyCfdi::ObtenerCertificado.new(cert_file)
pem = EasyCfdi::ObtenerLlave.new(pem_file)
    
# Instanciar el comprobante, pasando el certificado y la llave como parámetros:
@comprobante = EasyCfdi::Comprobante.new(certificado: cert, llave_pem: pem)

# Agregar al comprobante los nodos y los atributos necesarios 
# (Los nombres de los nodos son convertidos automaticamente a CammelCase al momento de generar el XML):
@comprobante.encabezado = EasyCfdi::Encabezado.new do |encabezado|
  encabezado.version = '3.3'
  encabezado.serie = 'F'
  encabezado.folio = '45612'
  encabezado.forma_pago = '01'
  encabezado.tipo_de_comprobante = 'I'
  encabezado.metodo_pago = 'PUE'
  encabezado.lugar_expedicion = '09070'
end

@comprobante.emisor = EasyCfdi::Emisor.new do |emisor|
  emisor.rfc = 'LAN7008173R5'
  emisor.nombre = 'Super Distribudora del Oriente SA de CV'
  emisor.regimen_fiscal = '601'
end
    
@comprobante.receptor = EasyCfdi::Receptor.new do |receptor|
  receptor.rfc = 'XAXX010101000'
  receptor.nombre = 'Rodolfo Carranza Ramos'
  receptor.uso_cfdi = 'G03'
end

# TODO - documentar el resto
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/havilchis/easy_cfdi.

## Acerca de.

Librería desarrollada por [Hugo Vilchis](https://www.linkedin.com/in/havilchis).


## License

Esta Gema se libera "Open Source" bajo los términos de la licencia MIT: [Ver licencia](LICENCE)
