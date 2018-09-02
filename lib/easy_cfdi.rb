# frozen_string_literal: true
require 'openssl' 
require 'krypt/ossl' if RUBY_PLATFORM =~ /java/
require 'nokogiri'
require 'ostruct'
require 'easy_cfdi/version'
require 'easy_cfdi/comprobante'
require 'easy_cfdi/build_xml'
require 'easy_cfdi/certificado_y_sello/obtener_certificado'
require 'easy_cfdi/certificado_y_sello/obtener_llave'
require 'easy_cfdi/certificado_y_sello/genera_cadena_y_sello'
require 'easy_cfdi/constructores_nodos/nodo_base.rb'
require 'easy_cfdi/constructores_nodos/encabezado'
require 'easy_cfdi/constructores_nodos/emisor'
require 'easy_cfdi/constructores_nodos/receptor'

module EasyCfdi
end
