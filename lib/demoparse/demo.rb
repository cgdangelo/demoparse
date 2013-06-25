require 'bindata'
require 'demoparse/header'
require 'demoparse/frame'

module Demoparse
  class Demo < BinData::Record
    endian :little
    count_bytes_remaining :bytes_remaining

    header :header

    array :frames, :adjust_offset => Header::HEADER_LENGTH,  :initial_length => 100 do
      frame :frame
    end

    def server_info_parsed?
      puts bytes_remaining
    end

    def old_server_version?
      self.header.network_protocol <= 43
    end
  end
end
