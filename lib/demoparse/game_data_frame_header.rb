module Demoparse
  class GameDataFrameHeader < BinData::Record
    endian :little
    struct   :resolution, :adjust_offset => :get_resolution_offset, :onlyif => :old_server_version? do
      skip   :length => 220
      uint32 :width
      uint32 :height
      skip   :length => 236
    end

    def get_resolution_offset
      if self.header.network_protocol == 43
        560
      else
        266
      end
    end
  end
end
