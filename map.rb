require 'gosu'
require_relative 'track_piece'

class Map

  def initialize(w_height,w_width)
    @track_pieces = []
    @track_pieces << TrackPiece.new(50,w_height-250,350,w_height-250)
  end

  def draw
    @track_pieces.each do | piece |
			piece.draw()
    end
  end

end
