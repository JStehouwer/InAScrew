require 'gosu'
#only supports lines for now
#(x1,y1) is top left, (x2,y2) is top right, further points are (x2,y2-h),(x1,y1-h)
class TrackPiece < Gosu::Image
  def initialize(x1,y1,x2,y2,h=5) #add type if adding non-lines
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
		@h = h
		@white = Gosu::Color::WHITE
  end

  def draw(camera_x, camera_y)
    Gosu.draw_quad(@x1-camera_x,@y1-camera_y,@white,
									 @x2-camera_x,@y2-camera_y,@white,
									 @x2-camera_x,@y2+@h-camera_y,@white,
									 @x1-camera_x,@y1+@h-camera_y,@white,
									 1)
  end
end
