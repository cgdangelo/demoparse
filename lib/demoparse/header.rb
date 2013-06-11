require 'demoparse/directory_entry'

module Demoparse
  class Header < BinData::Record
    HEADER_LENGTH = 544

    endian :little
    count_bytes_remaining :bytes_remaining

    string :gametype, :read_length => 8, :trim_padding => true
    uint32 :demo_protocol, :check_value => 5
    uint32 :network_protocol
    string :mapname, :read_length => 260, :trim_padding => true
    string :gamefolder, :read_length => 260, :trim_padding => true
    uint32 :mapchecksum

    uint32le :directory_entries_offset, :check_value => lambda { bytes_remaining - 4 - (2 * DirectoryEntry::DIRECTORY_ENTRY_LENGTH) }
    int32le  :directory_entries_total, :adjust_offset => :directory_entries_offset, :check_value => 2, :value => lambda { directory_entries.length }
    array  :directory_entries, :initial_length => :directory_entries_total do
      directory_entry :directory_entry
    end
  end
end
