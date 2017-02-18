require 'gosu'
require_relative 'track_piece'

class Map

  def initialize(w_height,w_width,rng,piece_length=300)
		@x_start = 50
		@length = piece_length
		@y_base = w_height-250
		@y_coords = [@y_base,@y_base]
		(1..4).each do |i|
			@y_coords << @y_coords[i-1]+rng.rand(-25..25)
		end
    @track_pieces = []
		(0..@y_coords.length-2).each do | i |
    	@track_pieces << TrackPiece.new(@x_start+@length*i,@y_coords[i],@x_start+@length*(i+1),@y_coords[i+1])
		end
  end

  def draw
    @track_pieces.each do | piece |
			piece.draw()
    end
  end

end
