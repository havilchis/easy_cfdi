module EasyCfdi
  class Nodos
    def initialize
      @opts = OpenStruct.new
      yield @opts
    end
    
    def to_hash
      hash = @opts.to_h
      hash.transform_keys! { |k| k.to_s.split('_').collect(&:capitalize).join.to_sym }
      hash
    end
  end
end