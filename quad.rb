require 'gosu'
require 'pry'

class Quad < Gosu::Window
  def initialize(x1,y1,x2,y2,x3,y3,x4,y4)
    @x1, @y1, @x2, @y2, @x3, @y3, @x4, @y4 = x1,y1,x2,y2,x3,y3,x4,y4
  end

  def draw(xCor, yCor)
    draw_quad(@x1 + xCor, @y1 + yCor, Gosu::Color.argb(0xffffffff), @x2 + xCor, @y2 + yCor, Gosu::Color.argb(0xffffffff), @x3 + xCor, @y3+yCor, 0xffffffff, @x4 + xCor, @y4 + yCor, Gosu::Color.argb(0xffffffff), z=1, mode = :default) #draw on coordinates
  end

  def toString
  	"1 " + @x1.to_s + " " + @y1.to_s + " " + @x2.to_s + " " + @y2.to_s + " " + @x3.to_s + " " + @y3.to_s + " " + @x4.to_s + " " + @y4.to_s
  end

	# Returns true if the point is inside the quadrangle
=begin
	def contains(x,y)
		puts" y1: #{@y1}, y2: #{@y2}, y3: #{@y3}, y4: #{@y4}"
		intersections = 0
		compare = 0
		(0..y).each do |i|
			puts "I: #{i}, Compare: #{compare}"
			if point_on_line([x.round,(compare+i)]) != 0
			puts "Line intersects with: #{point_on_line([x.round,(compare+i)])}"
			#	puts "Intersections: #{[x,i]}"
				intersections += 1
				compare += 10
			end
			if compare+i > y
				puts "stopped at at y: #{y}"
				break
			end
		end
		puts "Intersections #{intersections}"
		return intersections%2 == 1
	end

	# Returns true if the point lies on any perimeter line in the quadrangle
	def point_on_line(point)
		line1 = (1.0*(@y2-@y1).abs/(@x2-@x1).abs)*(point[0]-@x1) + @y1 
		if (line1.round-point[1]).abs < 4 and point[0].between?(@x1, @x2)
			return 1
		end
		line2 = (1.0*(@y3-@y2).abs/(@x3-@x2).abs)*(point[0]-@x2) + @y2 
		if (line2.round-point[1]).abs < 4 and point[0].between?(@x2, @x3)
			return 2
		end
		line3 = (1.0*(@y4-@y3).abs/(@x4-@x3).abs)*(point[0]-@x3) + @y3 
		if (line3.round-point[1]).abs < 4 and point[0].between?(@x3, @x4)
			return 3
		end
		line4 = (1.0*(@y1-@y4).abs/(@x1-@x4).abs)*(point[0]-@x4) + @y4 
		if (line4.round-point[1]).abs < 4 and point[0].between?(@x4, @x1)
			return 4
		end
		return 0
	end
=end
	
	def lowest_y_shape(rot=0) #get max y value
		return lowest_point()[1]
	end

	# Returns this shape's lowest point on the canvas
	def lowest_point
		ys = [@y1, @y2, @y3, @y4]
		xs = [@x1, @x2, @x3, @x4]
		return [xs[ys.index(ys.max)], ys.max]
	end

	# Returns this shape's lowest y value on the canvas
	def lowest_point_y
		ys = [@y1, @y2, @y3, @y4]
		return ys.max
	end

	# Returns this shape's highest point on the canvas
	def highest_point
		ys = [@y1, @y2, @y3, @y4]
		xs = [@x1, @x2, @x3, @x4]
		return [xs[ys.index(ys.min)], ys.min]
	end

	def other_points
		points = [[@x1, @y1], [@x2, @y2], [@x3, @y3], [@x4, @y4]]
		points - lowest_point
		points - highest_point
		return points
	end

	# Returns the lowest y value for a given x
	def lowest_for_x(x)
		lowest = lowest_point
		points = [[@x1, @y1], [@x2, @y2], [@x3, @y3], [@x4, @y4]]
		index = points.index(lowest)
		adj_points = [points[(index-1)%4], points[(index+1)%4]]
		left = adj_points[0][0] < lowest[0] ? adj_points[0] : adj_points[1]
		right = (adj_points-[left])[0]
		if left[0] <= x and x <= lowest[0]
			return y_val_on_slope(left[0],left[1],lowest[0],lowest[1],x)
		end
		if right[0] >= x and x >= lowest[0]
			return y_val_on_slope(right[0],right[1],lowest[0],lowest[1],x)
		end
		return nil
	end

	def leftmost_x
		xs = [@x1, @x2, @x3, @x4]
		return xs.min.round
	end

	def rightmost_x
		xs = [@x1, @x2, @x3, @x4]
		return xs.max.round
	end

	#find the lowest y cord for a given x cord
	def y_val_on_slope(xCor1, yCor1, xCor2, yCor2, x)
		return (findSlope(xCor1, yCor1, xCor2, yCor2) * (xCor1 - x) + yCor1).round
	end

	def findSlope(xCor1, yCor1, xCor2, yCor2)
		(yCor2-yCor1) / (xCor1 - xCor2)
	end

	def lowest_points
		vals = {}
		(leftmost_x..rightmost_x).each do |a|
			vals[a] = lowest_for_x(a)
		end
		return vals
	end
end
