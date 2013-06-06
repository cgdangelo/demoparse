require 'bindata'
require 'halflife/header'

module Halflife
  class Demo < BinData::Record
    header :header
  end
end
