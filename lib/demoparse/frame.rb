require 'demoparse/frame_header'
require 'demoparse/game_data_frame_header'

module Demoparse
  class Frame < BinData::Record
    endian :little
    frame_header :frame_header
    game_data_frame_header :game_data_frame_header
    uint32 :frame_length
  end
end
