require 'gosu'
require_relative 'map'
require_relative 'car'

class Main < Gosu::Window
  def initialize
    super 1024, 768
    self.caption = "Game"

		@rng = Random.new()
		@filename = "dopestCarEva.txt"
		# Parse arguments
		(0..ARGV.length-1).each do |arg|
			if ARGV[arg] == "-r"
				@rng = Random.new(ARGV[arg+1].to_i)
			end
			if ARGV[arg] == "-f"
				@filename = ARGV[arg+1]
			end
		end

		@map = Map.new(self.height,self.width,@rng,150)

    @background_image = Gosu::Image.new("media/background.png", :tileable=>true);
		@camera_x = 0
		@camera_y = 0
		@gravity = 3

		@car = Car.new(125, 400, @filename)
  end

  def update
    if Gosu.button_down?(Gosu::KB_RIGHT)
			@car.move(-20, 0)
		elsif Gosu.button_down?(Gosu::KB_UP)
			@camera_y -= 20
		elsif Gosu.button_down?(Gosu::KB_DOWN)
			@camera_y += 20
		elsif Gosu.button_down?(Gosu::KB_SPACE)
			@start = true
		end
		if @start
			# Move car here
			@car.move(1, 0)
			@camera_x += 1
			feel_gravity()
		end
  end

	
	def feel_gravity()
		dist_below_ground = @map.is_grounded2(@car)
		if dist_below_ground < -1.0*@gravity #if there is a part of it below ground
			@car.gravitize(@gravity) #otherwise, keep down
		else
			@car.upto(dist_below_ground) #push up
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
