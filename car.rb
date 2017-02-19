require 'gosu'

class Car

	def initialize(x_anchor, y_anchor)
		@x_anchor = x_anchor
		@y_anchor = y_anchor
		@rot = 0
		@white = Gosu::Color::WHITE
	end

	def draw(camera_x, camera_y)
		Gosu.draw_quad(@x_anchor-camera_x-50,@y_anchor-50-camera_y,@white,
									 @x_anchor-camera_x+50,@y_anchor-50-camera_y,@white,
									 @x_anchor-camera_x+50,@y_anchor+50-camera_y,@white,
									 @x_anchor-camera_x-50,@y_anchor+50-camera_y,@white,
									 2)
	end

	def gravitize(gravity)
		@y_anchor += gravity
	end

	def upto(value)
		@y_anchor = value - 50
	end

	def move(x, y)
		@x_anchor += x
		@y_anchor += y
	end

	def rightmost_point
		return @x_anchor+50
	end

	def leftmost_point
		return @x_anchor-50
	end

	def lowest_points
		result = {}
		(@x_anchor-50..@x_anchor+50).each do |x|
			result[x] = @y_anchor+50
		end
		return result
	end

	def get_x
		return @x_anchor
	end

	def load
    	shapeArray = Array.new
    	f = File.open("dopestCarEva.txt", "r")
    	f.each_line { |line|
    		words = line.split
    		numbers = Array.new
    		words.each{|word| numbers.push(word.to_f)}
    		print words[0]
    		print words[1]
    		if numbers[0] == 1
        		shapeArray.push(Quad.new(numbers[1],numbers[2],numbers[3],numbers[4],numbers[5],numbers[6],numbers[7],numbers[8]))
    		elsif numbers[0] == 2
        		shapeArray.push(Circle.new(numbers[1],numbers[2],numbers[1]+numbers[3],numbers[2]))
    		end
    	}
    	f.close
  end

end
