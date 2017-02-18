require 'gosu'
require_relative 'map'

class Main < Gosu::Window
  def initialize
    super 1024, 768
    self.caption = "Game"
		@map = Map.new(self.height,self.width)

    @background_image = Gosu::Image.new("media/background.png", :tileable=>true);
		puts self.height
  end

  def update
    # ...
  end

  def draw
		@map.draw
    @background_image.draw(0,0,0)
  end
end

Main.new.show
