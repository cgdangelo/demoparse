module Demoparse
  class DirectoryEntry < BinData::Record
    DIRECTORY_ENTRY_LENGTH = 92

    skip     :length => 4
    string   :title, :read_length => 64, :trim_padding => true
    skip     :length => 8
    float_le :entry_time, :read_length => 4
    skip     :length => 12
  end
end
