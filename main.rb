require 'gosu'
require_relative 'map'

class Main < Gosu::Window
  def initialize
    super 1024, 768
    self.caption = "Game"
		rng = Random.new()
		@map = Map.new(self.height,self.width,rng,150)

    @background_image = Gosu::Image.new("media/background.png", :tileable=>true);
		@camera_x = 0
		@camera_y = 0
  end

  def update
    if Gosu.button_down?(Gosu::KB_RIGHT)
			@camera_x += 20
		end
		if Gosu.button_down?(Gosu::KB_LEFT)
			@camera_x -= 20
		end
		if Gosu.button_down?(Gosu::KB_UP)
			@camera_y -= 20
		end
		if Gosu.button_down?(Gosu::KB_DOWN)
			@camera_y += 20
		end
  end

  def draw
		@map.draw(@camera_x, @camera_y)
    @background_image.draw(0,0,0)
  end

	def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Main.new.show
