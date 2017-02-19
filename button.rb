require 'gosu'

class Button
  def initialize(x1, y1, fileName, fileName2, width, height)
    @x1, @y1, @fileName, @fileName2, @width, @height = x1,y1, fileName, fileName2, width, height 
    @button = Gosu::Image.new(@fileName,:tileable=>true)
  end

  attr_accessor :x1, :y1, :width, :height

  def isClicked(myX, myY)
      (myY>y1 and myY<y1+height and myX>x1 and myX < x1+width)
  end

  def onClick
    @button = Gosu::Image.new(@fileName2,:tileable=>true)
  end

  def onRelease
    @button = Gosu::Image.new(@fileName,:tileable=>true)
  end

  def draw
    @button.draw(@x1,@y1,5) #drawing at center
  end

end
