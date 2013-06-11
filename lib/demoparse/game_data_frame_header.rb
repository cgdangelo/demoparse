module Demoparse
  class GameDataFrameHeader < BinData::Record
    endian :little
    uint32 :resolution_width
    uint32 :resolution_height
    uint32 :len
  end
end
