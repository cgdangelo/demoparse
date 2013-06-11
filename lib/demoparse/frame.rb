require 'demoparse/frame_header'
require 'demoparse/game_data_frame_header'

module Demoparse
  class Frame < BinData::Record
    frame_header           :frame_header
    game_data_frame_header :game_data_frame_header
  end
end
