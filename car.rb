require 'gosu'
require_relative 'circle.rb'
require_relative 'quad.rb'


class Car

	def initialize(x_anchor, y_anchor)
		@x_anchor = x_anchor
		@y_anchor = y_anchor
		@rot = 0
		@white = Gosu::Color::WHITE
		@carArray = load()
	end

	def draw(camera_x, camera_y)
=begin
		Gosu.draw_quad(@x_anchor-camera_x-50,@y_anchor-50-camera_y,@white,
									 @x_anchor-camera_x+50,@y_anchor-50-camera_y,@white,
									 @x_anchor-camera_x+50,@y_anchor+50-camera_y,@white,
									 @x_anchor-camera_x-50,@y_anchor+50-camera_y,@white,
									 2)
=end
		@carArray.each{|shape| shape.draw(@x_anchor, @y_anchor)}
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
		leftmost = @carArray.map{|shape| shape.leftmost_x}.min
		#puts(leftmost)
		rightmost = @carArray.map{|shape| shape.rightmost_x}.max
		#puts(rightmost)
		result = {}
		(leftmost..rightmost).each do |x|
			max_y = 0
			@carArray.each do |shape|
				y = shape.lowest_for_x(x)
				y = y ? y+@y_anchor : 0
				#puts(y)
				if y
					max_y = max_y > y ? max_y : y
				end
			end
			result[x] = max_y
		end
		return result
	end

	def get_anchor
		return [@x_anchor,@y_anchor]
	end

	def lowest_point
		lowest = [@carArray.map{|shape|shape.lowest_point}].max
		puts("lowest point" , lowest)
		return lowest
	end

#takes care from .txt file and puts into array shapeArray
	def load
  	shapeArray = Array.new
  	f = File.open("dopestCarEva.txt", "r")
  	f.each_line { |line|
  		words = line.split
  		numbers = Array.new
  		words.each{|word| numbers.push(word.to_f)}
  		if numbers[0] == 1
      		shapeArray.push(Quad.new(numbers[1],numbers[2],numbers[3],numbers[4],numbers[5],numbers[6],numbers[7],numbers[8]))
  		elsif numbers[0] == 2
      		shapeArray.push(Circle.new(numbers[1],numbers[2],numbers[1]+numbers[3],numbers[2]))
  		end
  	}
  	f.close
		return shapeArray
	end

end
