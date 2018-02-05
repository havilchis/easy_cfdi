require 'nokogiri'
require 'openssl'
require "easy_cfdi/version"
require "easy_cfdi/build_xml"
require "easy_cfdi/certificado_y_sello/obtener_certificado"
require "easy_cfdi/certificado_y_sello/obtener_llave"
require "easy_cfdi/certificado_y_sello/genera_cadena_y_sello"

module EasyCfdi
 class Comprobante
   attr_accessor :encabezado, :emisor, :receptor
   attr_reader :certificate

   def initialize(options={})
     @certificate = options[:certificado]
     @llave_pem = options[:llave_pem]
   end

   def encabezado
     #Se agrega al encabezado previamente subido por el usuario los attributos
     #NoCertificado y Certificado. A menos que el usuario haya ingresado estos valores
     #manualmente.
     @encabezado[:NoCertificado] = @certificate.numero_certificado unless @encabezado.key? :NoCertificado
     @encabezado[:Certificado] = @certificate.certificado unless @encabezado.key? :Certificado
     @encabezado
   end

   def construye_xml
      builder = BuildXml.new(encabezado: self.encabezado,
        emisor: self.emisor,
        receptor: self.receptor
      )
      builder.xml_content
   end

   def genera_sello
     # Se carga la plantilla oficial del SAT que servirá para general la cadena_original
     template = Nokogiri::XSLT(File.read('vendor/plantillas_sat/cadenaoriginal_3_3.xslt'))

     # Se genera la cadena original usando el template de arriba como plantilla
     # se hace un Split porque la Cadena se encuentra en la última línea del string devuelto
     cadena_original = template.transform(Nokogiri::XML(self.construye_xml)).to_s.split("\n").last

     # Se carga la llave para sellar en formato PEM
     # Se obtiene con: (openssl pkcs8 -inform DET -in aaa010101aaa.key -passin pass:12345678a -out key.pem)
     key = OpenSSL::PKey::RSA.new File.read("./spec/certificados/key.pem")

     # Se especifica que el formato de digestión estará en SHA256
     digest = OpenSSL::Digest::SHA256.new

     #Esta línea sella la cadena original con el archivo PEM, usando SHA 256. Devuelve un binario
     sello =  key.sign(digest, cadena_original)

     # Se transforma el sello de binario a Base64 y se eliminan los caracteres de salto de línea.
     # este string está listo para añadirse al XML.
     Base64.encode64(sello).gsub(/\n/,"")
     cadena_original
   end

 end
end
