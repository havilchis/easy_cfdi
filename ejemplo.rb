require "awesome_print"
require "json"
require "yaml"

class	CFDI
	attr_accessor :conceptos
	def initialize(options={})
		@conceptos = []
		@hash = {}
	end

	def emisor=(hash)
		if hash.class != Hash
			raise("El Emisor debe ser un Hash, usted ha ingresado un #{hash.class}. ¿Ha escrito su variable correctamente?")
		end
		@hash[:emisor] = hash
	end

	def conceptos=(hash)
		@conceptos<< hash
	end

	def body
		@hash[:conceptos] = @conceptos
		@hash
	end
end

class	GeneraConcepto
	def initialize(options={})
		@traslados = []
		@hash = {}
		@hash[:cantidad] = options[:cantidad]
		@hash[:unidad] = options[:unidad]
		@hash[:traslados] = []
	end

	def add_traslado=(hash)
		@hash[:traslados]<< hash
		@traslados
	end

	def body
		 @hash
	end
end

factura.emisor = {Rfc: 'AAAA010101XXX', Nombre: "Distribuidora del Norte #{Time.now.to_s}"}


(1..5).each do |c|
	concepto_individual =  GeneraConcepto.new(Cantidad: '1', Unidad: "Producto #{c}", Nombre: 'Manzana')
	concepto_individual.add_traslado = {nombre: 'ieps', TasaOCuota: '0.10'}
	concepto_individual.add_traslado = {nombre: 'iva', TasaOCuota: '0.16'}
	factura.conceptos << concepto_individual.body #no olvidarse del .body al final
end

puts factura.body.to_json
