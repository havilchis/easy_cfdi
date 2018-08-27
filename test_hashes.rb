require 'awesome_print'
require "nokogiri"

class MainCfdi
  attr_accessor :nodo
  def initialize

  end

  def nodo
    @nodo
  end
end

class Relacionados
  def self.add(uuid, tipo_relacion)
    hash = {}
    hash[:uuid] = uuid
    hash[:tipoRelacion] = tipo_relacion
    hash
  end
end

class Producto
  def self.impuesto_transladado(name)

  end
end

factura = MainCfdi.new
factura.nodo = []
factura.nodo << Relacionados.add('XXXX00004', '04')
factura.nodo << Relacionados.add('XXXX00003', '03')

producto = Producto.new(name: 'prod01')
producto.impuesto_transladado =

ap factura.nodo

builder = Nokogiri::XML::Builder.new(:encoding => 'utf-8'){|xml|
 xml.DocumentosRelacionados()do
 factura.nodo.each do |value|
  xml.CfdiRelacionado(value) do
  end
 end
 end

}.to_xml

puts builder
