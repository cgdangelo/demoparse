require 'bindata'
require 'demoparse/header'

module Demoparse
  class Demo < BinData::Record
    header :header
  end
end
