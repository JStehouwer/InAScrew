require 'gosu'

class CarMaker < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Tutorial Game"
    @rectangles = Array.new
    @clickedX = 0
    @clickedY = 0
  end

  def update
    # ...
  end

  def draw
    # ...
  end
end

CarMaker.new.show
