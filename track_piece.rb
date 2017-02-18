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

  def draw
    Gosu.draw_quad(@x1,@y1,@white,@x2,@y2,@white,@x2,@y2+@h,@white,@x1,@y1+@h,@white,1)
  end
end
