require 'gosu'

class Car

	def initialize(x_anchor, y_anchor)
		@x_anchor = x_anchor
		@y_anchor = y_anchor
		@rot = 0
		@white = Gosu::Color::WHITE
	end

	def draw(camera_x, camera_y)
		Gosu.draw_quad(@x_anchor-50,@y_anchor-50-camera_y,@white,
									 @x_anchor+50,@y_anchor-50-camera_y,@white,
									 @x_anchor+50,@y_anchor+50-camera_y,@white,
									 @x_anchor-50,@y_anchor+50-camera_y,@white,
									 2)
	end

end
