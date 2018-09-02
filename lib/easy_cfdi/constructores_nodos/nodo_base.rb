# frozen_string_literal: true
module EasyCfdi
  class NodoBase
    def initialize
      @opts = OpenStruct.new
      yield @opts
    end

    def to_hash
      hash = @opts.to_h     
      hash = camelize_keys(hash)
    end
    
    private

    def camelize_keys(hash)
      hash.keys.each do |k|
        # hash[:new_key] = hash.delete(:old_key)
        # The #delete method on a hash will return the value of the key provided while 
        # removing the item from the hash. 
        # The resulting hash gets a new key assigned to the old key’s value.
        hash[k.to_s.split('_').collect(&:capitalize).join.to_sym] = hash.delete(k)
      end
      hash
    end
  end
end