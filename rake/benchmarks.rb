# frozen_string_literal: true
require 'benchmark'

command =  system("rspec spec/comprobante_spec.rb") 
n = 10000000000


Benchmark.bm do |x|
  x.report { n.times do   ; command ; end }
end