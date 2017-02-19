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
    Gosu.draw_quad(@x1-camera_x,@y1,@white,
									 @x2-camera_x,@y2,@white,
									 @x2-camera_x,@y2+@h,@white,
									 @x1-camera_x,@y1+@h,@white,
									 1)
  end

  def get_h
  	return @h
  end

  def get_y1
  	return @y1
  end

  def get_slope
  	return (@y2.to_f-@y1.to_f)/(@x2.to_f-@x1.to_f)
  end

	def below_object(object_left, object_right, object_points)
		unless object_right < @x1 or object_left > @x2
			#puts("in bounds")
			if @slope > 0 # \
				#puts(@slope)
				(@x1..@x2).each do |x|
					if object_points[x] # If car has point here
						puts(object_points[x])
						if object_points[x] > @y1+@slope*(x-@x1)
							#puts(x)
							return [(@y1+@slope*(x-@x1)),x] #returns the first point below, and the x-value
						end
					end
				end
			else # else slope /
				#puts(@slope)
				(@x2).downto(@x1) do |x|
					if object_points[x] # If car has point here
						if object_points[x] > @y1+@slope*(x-@x1)
							#puts(x)
							return [(@y1+@slope*(x-@x1)),x]
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
