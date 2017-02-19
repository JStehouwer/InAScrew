require 'gosu'

class Quad < Gosu::Window
  def initialize(x1,y1,x2,y2,x3,y3,x4,y4)
    @x1, @y1, @x2, @y2, @x3, @y3, @x4, @y4 = x1,y1,x2,y2,x3,y3,x4,y4
  end

  def draw
    draw_quad(@x1, @y1, Gosu::Color.argb(0xffffffff), @x2, @y2, Gosu::Color.argb(0xffffffff), @x3, @y3, 0xffffffff, @x4, @y4, Gosu::Color.argb(0xffffffff), z=1, mode = :default)
  end

  def toString
  	"1 " + @x1.to_s + " " + @y1.to_s + " " + @x2.to_s + " " + @y2.to_s + " " + @x3.to_s + " " + @y3.to_s + " " + @x4.to_s + " " + @y4.to_s
  end

end
