require 'gosu'
require 'pry'

#only supports lines for now
#(x1,y1) is top left, (x2,y2) is top right, further points are (x2,y2-h),(x1,y1-h)
class TrackPiece < Gosu::Image
  def initialize(x1,y1,x2,y2,h=30) #add type if adding non-lines
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
		@h = h
		@slope = (1.0*(y2-y1))/(x2-x1)
		@white = Gosu::Color::WHITE
  end

  def draw(camera_x, camera_y)
    Gosu.draw_quad(@x1-camera_x,@y1-camera_y,@white,
									 @x2-camera_x,@y2-camera_y,@white,
									 @x2-camera_x,@y2+@h-camera_y,@white,
									 @x1-camera_x,@y1+@h-camera_y,@white,
									 1)
  end

	def below_object(object_left, object_right, object_points)
		unless object_right < @x1 or object_left > @x2
			if @slope > 0
				(@x1..@x2).each do |x|
					if object_points[x] # If car has point here
						if object_points[x] > @y1+@slope*(x-@x1)
							return @y1+@slope*(x-@x1)
						end
					end
				end
			else
				(@x2).downto(@x1) do |x|
					if object_points[x] # If car has point here
						if object_points[x] > @y1+@slope*(x-@x1)
							return @y2-@slope*(@x2-x)
						end
					end
				end
			end
		end
		return -1
	end

	def get_left
		return @x1
	end
end
