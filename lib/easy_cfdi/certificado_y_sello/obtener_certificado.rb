module EasyCfdi
  class ObtenerCertificado < OpenSSL::X509::Certificate
    def numero_certificado
      numero_certificado = ''
      self.serial.to_s(16).scan(/.{2}/).each{ |v| numero_certificado << v[1] }
      numero_certificado
    end

    def certificado
      self.to_s.gsub(/^-.+/, '').gsub(/\n/, '')
    end

    def expires_at
      self.not_after
    end

    def valid?(current_datetime = Time.now.utc)
      self.expires_at > current_datetime
    end
  end
end
