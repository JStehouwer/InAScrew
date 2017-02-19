require 'gosu'
require_relative 'track_piece'

require 'pry'

class Map

  def initialize(w_height,w_width,rng,piece_length=300)
		@x_start = 50
		@length = piece_length
		@y_base = w_height-250
		coord_heights = [-60, -45, -30, -15, 0, 15, 30, 45, 60]
		@y_coords = [@y_base,@y_base]
		(1..500).each do |i|
			#@y_coords << @y_coords[i-1]+coord_heights[rng.rand(0..coord_heights.length-1)]
			@y_coords << @y_coords[i=1]+rng.rand(-50..50)
		end
    @track_pieces = []
		(0..@y_coords.length-2).each do | i |
    	@track_pieces << TrackPiece.new(@x_start+@length*i,@y_coords[i],@x_start+@length*(i+1),@y_coords[i+1])
		end
  end

  def draw(camera_x, camera_y)
    @track_pieces.each do | piece |
			piece.draw(camera_x, camera_y)
    end
  end

	# returns first y val lower than the line, if there are no y vals lower than the line return -1
	def is_grounded(object)
		puts "Is he below anyone?"
		object_points = object.lowest_points() #hash returning all lowest points for each x
		@track_pieces.each do |piece| #for each track piece
			val = piece.below_object(object.leftmost_point, object.rightmost_point, object_points) #returns y of first piece that is below line (starting from left on \ and right on /)
			if val != -1
				new_y_anchor = val[0]-object_points[val[1]] #subtracts the lowest point, to go from the proper location of the lowest point to the proper location of y_anchor
				return new_y_anchor #return first y val that is lower than line / proper location of y_anchor 
			end
		end
		return -1 
	end
end
