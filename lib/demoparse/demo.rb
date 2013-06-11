require 'bindata'
require 'demoparse/header'
require 'demoparse/frame'

module Demoparse
  class Demo < BinData::Record
    attr_accessor :server_info_parsed

    header :header

    array :frames, :adjust_offset => Demoparse::Header::HEADER_LENGTH, :type => :frame
  end
end
