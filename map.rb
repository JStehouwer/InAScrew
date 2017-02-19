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
		obj_low = object.lowest_point_y
		obj_low_y = obj_low[1]
		object_x = obj_low[0]
		piece_num = object_x.to_i/@length.to_i
		piece_offset = object_x.to_i%@length.to_i
		track_y = (@track_pieces[piece_num]).get_y1 + @track_pieces[piece_num].get_slope*piece_offset + @track_pieces[piece_num].get_h
		puts ("object_x")
		puts (object_x)
		puts ("obj_low_y")
		puts(obj_low_y)
		puts ("track_y")
		puts(track_y)
		return obj_low_y - track_y
	end

		# returns first y val lower than the line, if there are no y vals lower than the line return -1
	def is_grounded2(object)
		#worryPoints = object.lowest_points2
		#for x in 0..object.rightmost_point
		#	if not worryPoints[x].nil?
		#		piece_num = (x+object.get_x).to_i/@length.to_i
		#		piece_offset = (x+object.get_x).to_i%@length.to_i
		#		track_y = (@track_pieces[piece_num]).get_y1 + @track_pieces[piece_num].get_slope*piece_offset + @track_pieces[piece_num].get_h
		#		worryPoints[x] = track_y - worryPoints[x]
		#	end
		#end
		#pp = worryPoints.values.min
		obj_low = object.lowest_point_y
		obj_low_y = obj_low[1]
		object_x = obj_low[0]
		piece_num = object_x.to_i/@length.to_i
		piece_offset = object_x.to_i%@length.to_i
		track_y = (@track_pieces[piece_num]).get_y1 + @track_pieces[piece_num].get_slope*piece_offset + @track_pieces[piece_num].get_h
		return obj_low_y - track_y
	end
end
