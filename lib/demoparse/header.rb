require 'demoparse/directory_entry'

module Demoparse
  class Header < BinData::Record
    HEADER_LENGTH = 544

    endian :little
    string :gametype, :read_length => 8, :trim_padding => true
    uint32 :demo_protocol, :check_value => 5
    uint32 :network_protocol
    string :mapname, :read_length => 260, :trim_padding => true
    string :gamefolder, :read_length => 260, :trim_padding => true
    uint32 :mapchecksum
    uint32 :directory_entries_offset, :check_value => lambda { num_bytes - 4 - (Demoparse::DirectoryEntry::DIRECTORY_ENTRY_LENGTH * 2) }
    int32  :directory_entries_total, :adjust_offset => :directory_entries_offset, :check_value => 2, :value => lambda { directory_entries.length }

    array :directory_entries, :initial_length => 2 do
      directory_entry :directory_entry
    end
  end
end
