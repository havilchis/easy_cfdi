class Comprobante
  attr_accessor :encabezado

  def initialize
  end

  def encabezado(&block)
    self.encabezado = Struct.new(:hola)
    self.encabezado.hola
  end
end

class Head
    attr_accessor :version, :serie, :folio, :forma_pago, :tipo_de_comprobante
  
    def initialize
      yield(self)
    end
end
  
cfdi = Comprobante.new

cfdi.encabezado do |c|
  c.hola = "mundo"
end

puts cfdi.encabezado.class

