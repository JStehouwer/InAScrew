require 'gosu'
require_relative 'map'
require_relative 'car'

class Main < Gosu::Window
  def initialize
    super 1024, 768
    self.caption = "Game"

		rng = Random.new()
		# Parse arguments
		(0..ARGV.length-1).each do |arg|
			if ARGV[arg] == "-r"
				rng = Random.new(ARGV[arg+1].to_i)
				puts "Seed set"
			end
		end

		@map = Map.new(self.height,self.width,rng,150)

    @background_image = Gosu::Image.new("media/background.png", :tileable=>true);
		@camera_x = 0
		@camera_y = 0
		@gravity = 3

		@car = Car.new(125, 400)
  end

  def update
    if Gosu.button_down?(Gosu::KB_RIGHT)
			@camera_x += 20
			@car.move(20, 0)
		end
		if Gosu.button_down?(Gosu::KB_LEFT)
			@camera_x -= 20
			@car.move(-20, 0)
		end
		if Gosu.button_down?(Gosu::KB_UP)
			@camera_y -= 20
		end
		if Gosu.button_down?(Gosu::KB_DOWN)
			@camera_y += 20
		end
		if Gosu.button_down?(Gosu::KB_SPACE)
			@start = true
		end
		if @start
			# MOve car here
			@car.move(5, 0)
			@camera_x += 5
			feel_gravity(@car)
		end
  end

	def feel_gravity(object)
		val = @map.is_grounded(@car)
		if val != -1
			@car.upto(val)
		else
			@car.gravitize(@gravity)
		end
	end

  def draw
		@car.draw(@camera_x,@camera_y)
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
