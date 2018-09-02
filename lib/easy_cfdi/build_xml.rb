# frozen_string_literal: true
module EasyCfdi

  class BuildXml
    def initialize(options={})
      @encabezado = options[:encabezado]
      @emisor = options[:emisor]
      @receptor = options[:receptor]
    end

    def xml_content
      Nokogiri::XML::Builder.new(:encoding => 'utf-8'){|xml|
        xml.Comprobante(@encabezado)do
          ins = xml.doc.root.add_namespace_definition('cfdi', 'http://www.sat.gob.mx/cfd/3')
          xml.doc.root.namespace = ins
          xml.Emisor(@emisor)
          xml.Receptor(@receptor)
          xml.Conceptos do
            xml.Concepto
          end
        end
      }.to_xml
    end

  end
end
