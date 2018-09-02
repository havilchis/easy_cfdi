# frozen_string_literal: true
###############################################################################
# Esta rutina sólo tiene utilidad en Desarrollo, nunca es invocada en Producción
# se puede ejecutar manualmente cuando se considere necesario actualizar las --
# descargas de las planillas xslt del SAT dentro de la gema.
#
# Ejecutar directamente, o con: 'rake descargar_xslt'
#
# Objetivo:
#   Descargar localmente todas las planillas xslt requeridas para generar la --
#   cadena original en el CFDI. Así se acorta su generación de 4 segundos a --
#   sólo milisegundos.
# Pasos:
#   * Se Lee el contenido del archivo /vendor/cadenaoriginal_3_3.xslt.original
#   * Se Descargan todas las platillas de los nodos "include" localmente en --
#      /vendor/plantillas_sat
#   * Se Genera el arhivo '/vendor/plantillas_sat/cadenaoriginal_3_3.xslt' con
#     los nodos 'include' apuntando a los archivos locales.
#                                                           Con amor: @havilchis
###############################################################################

require 'nokogiri'
require 'net/http'


source = Nokogiri::XML(File.read("./vendor/cadenaoriginal_3_3.xslt.original"))

target_path = './vendor/plantillas_sat/'

source.xpath("//xsl:include").each do |link|
  url = link['href']

  # Se cambia la extensión .xslt a .xslt.rb para que las busquedas en Github --
  # muestren el repositorio como código Ruby y no como HTML.
  # Qué truzaco, ¿no? (guiño)
  filename = target_path + url.split('/')[-1] + '.rb' # => Ej: /xsd/utilerias.xslt.rb

  File.open(filename, "w") do |f|
    uri = URI(url)
    f << Net::HTTP.get(uri)
    puts 'Created file: ' + filename
  end
  link['href'] = filename
end

File.write( target_path + 'cadenaoriginal_3_3.xslt', source)
puts 'Todas las plantillas fueron descargadas. Saliendo...'
