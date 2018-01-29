require "openssl"
module EasyCfdi
  class ObtenerCertificado
    def initialize(certificate)
      @certificate = OpenSSL::X509::Certificate.new(certificate)
    end

    def numero_certificado
      numero_certificado = ''
      @certificate.serial.to_s(16).scan(/.{2}/).each{ |v| numero_certificado << v[1] }
      numero_certificado
    end

    def content
      @certificate.to_s.gsub(/^-.+/, '').gsub(/\n/, '')
    end
  end
end
