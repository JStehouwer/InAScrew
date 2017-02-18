require 'gosu'

class Circle
  def initialize(x1, y1, x2, y2)
    @x1, @y1 = x1,y1 #center of circle
    @radius = dist(x1, y1, x2, y2)
    @circle = Gosu::Image.new("media/circle.png",:tileable=>true)
  end

  def draw
    @circle.draw(@x1-@radius,@y1-@radius,2,@radius*0.006,@radius*0.006) #drawing at center
  end

  def dist(spotX, spotY, spotX2, spotY2)
     Math.sqrt( (spotX - spotX2)*(spotX - spotX2) + (spotY - spotY2)*(spotY - spotY2) )
  end

end
