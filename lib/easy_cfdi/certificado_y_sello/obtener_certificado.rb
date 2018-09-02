# frozen_string_literal: true
module EasyCfdi
  class ObtenerCertificado < OpenSSL::X509::Certificate
    
    DIVIDE_SERIAL_IN_GROUPS_OF_TWO_DIGITS = /.{2}/
    APPEND_ONLY_SECOND_DIGIT_OF_EACH_GROUP = 1
    CREATE_STRING_FROM_ARRAY_OF_DIGITS_WITH_COMMA = ","
    REPLACE_COMMAS_OF_STRING = ","
    BY_NOTHING = ""

    def extract_numbers_in_serial_into_sat_format(serial)
      serial.scan(DIVIDE_SERIAL_IN_GROUPS_OF_TWO_DIGITS)
            .map{ |v| v[APPEND_ONLY_SECOND_DIGIT_OF_EACH_GROUP] }
            .join(CREATE_STRING_FROM_ARRAY_OF_DIGITS_WITH_COMMA)
            .gsub(REPLACE_COMMAS_OF_STRING, BY_NOTHING)
    end          

    def numero_certificado
      extract_numbers_in_serial_into_sat_format(self.serial.to_s(16))
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
