require 'bindata'
require 'demoparse/header'
require 'demoparse/frame'

module Demoparse
  class Demo < BinData::Record
    attr_accessor :server_info_parsed

    endian :little
    count_bytes_remaining :bytes_remaining

    string     :gametype, :read_length => 8, :trim_padding => true
    uint32     :demo_protocol, :check_value => 5
    uint32     :network_protocol
    string     :mapname, :read_length => 260, :trim_padding => true
    string     :gamefolder, :read_length => 260, :trim_padding => true
    uint32     :mapchecksum

    uint32le   :directory_entries_offset, :check_value => lambda { bytes_remaining - 4 - (2 * DirectoryEntry::DIRECTORY_ENTRY_LENGTH) }
    int32le    :directory_entries_total, :adjust_offset => :directory_entries_offset, :check_value => 2, :value => lambda { directory_entries.length }
    array      :directory_entries, :initial_length => :directory_entries_total do
      skip     :length => 4
      string   :title, :read_length => 64, :trim_padding => true
      skip     :length => 8
      float_le :entry_time, :read_length => 4
      skip     :length => 12
    end

    array      :frames, :adjust_offset => Header::HEADER_LENGTH, :read_until => :server_info_parsed? do
      uint8    :type
      float_le :timestamp
      uint32   :number

      struct   :resolution, :adjust_offset => :get_resolution_offset, :onlyif => :old_server_version? do
        skip   :length => 220
        uint32 :width
        uint32 :height
        skip   :length => 236
      end

      uint32   :frame_length
    end

    def server_info_parsed?
      puts bytes_remaining
    end

    def old_server_version?
      network_protocol <= 43
    end

    def get_resolution_offset
      if network_protocol == 43
        560
      else
        266
      end
    end
  end
end
