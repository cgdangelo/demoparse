module Demoparse
  class FrameHeader < BinData::Record
    endian :little
    uint8 :type
    float_le :timestamp
    uint32 :number
  end
end
