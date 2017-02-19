require 'gosu'
require_relative 'circle.rb'
require_relative 'quad.rb'


class Car

	def initialize(x_anchor, y_anchor, filename)
		@x_anchor = x_anchor
		@y_anchor = y_anchor
		@rot = 0
		@white = Gosu::Color::WHITE
		@filename = filename
		@carArray = load()
	end

	def draw(camera_x, camera_y)
		@carArray.each{|shape| shape.draw(@x_anchor-camera_x, @y_anchor)}
	end

	def gravitize(gravity)
		@y_anchor += gravity
	end

	def upto(value)
		@y_anchor += -1.0 * value
	end

	def move(x, y)
		@x_anchor += x
		@y_anchor += y
	end

	def rightmost_point
		return @carArray.map{|shape| shape.rightmost_x}.max
	end

	def leftmost_point
		return @carArray.map{|shape| shape.leftmost_x}.min
	end

	def lowest_points
		leftmost = @carArray.map{|shape| shape.leftmost_x}.min
		rightmost = @carArray.map{|shape| shape.rightmost_x}.max
		result = {}
		(leftmost..rightmost).each do |x|
			max_y = 0
			@carArray.each do |shape|
				y = shape.lowest_for_x(x)
				if y
					y += @y_anchor
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
		return lowest+@y_anchor
	end

	def lowest_point_y
		lowest = 0
		lowest_x = 0
		@carArray.each do |x|
			if x.lowest_point[1] > lowest
				lowest = x.lowest_point[1]
				lowest_x = x.lowest_point[0]
			end
		end
		return [lowest_x+@x_anchor,lowest+@y_anchor]
	end

	def lowest_points2
		vals = {}
		@carArray.each do |x|
			temp_vals = x.lowest_points
			for i in (x.leftmost_x .. x.rightmost_x)
				if (vals[i].nil? and temp_vals[i]) or temp_vals[i] > vals[i]
					vals[i] = temp_vals[i]+@y_anchor
				end
			end
		end
		return vals
	end

	#takes car from .txt file and puts into array shapeArray
	def load
  	shapeArray = Array.new
  	f = File.open(@filename, "r")
  	f.each_line do |line|
  		words = line.split
  		numbers = Array.new
  		words.each do |word|
				numbers.push(word.to_f)
			end
	  	if numbers[0] == 1
      	shapeArray.push(Quad.new(numbers[1],numbers[2],numbers[3],numbers[4],numbers[5],numbers[6],numbers[7],numbers[8]))
	 		elsif numbers[0] == 2
     		shapeArray.push(Circle.new(numbers[1],numbers[2],numbers[1]+numbers[3],numbers[2]))
  		end
  	end
  	f.close
		return shapeArray
	end

	def get_x
		return @x_anchor
	end
end
