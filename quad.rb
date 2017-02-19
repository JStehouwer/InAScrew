require 'gosu'
require 'pry'

class Quad < Gosu::Window
  def initialize(x1,y1,x2,y2,x3,y3,x4,y4)
    @x1, @y1, @x2, @y2, @x3, @y3, @x4, @y4 = x1,y1,x2,y2,x3,y3,x4,y4
  end

  def draw(xCor, yCor)
    draw_quad(@x1, @y1 + yCor, Gosu::Color.argb(0xffffffff), @x2, @y2 + yCor, Gosu::Color.argb(0xffffffff), @x3, @y3+yCor, 0xffffffff, @x4, @y4 + yCor, Gosu::Color.argb(0xffffffff), z=1, mode = :default) #draw on coordinates
  end

  def toString
  	"1 " + @x1.to_s + " " + @y1.to_s + " " + @x2.to_s + " " + @y2.to_s + " " + @x3.to_s + " " + @y3.to_s + " " + @x4.to_s + " " + @y4.to_s
  end
	
	def lowest_y_shape(rot=0) #get max y value
		return lowest_point()[1]
	end

	# Returns this shape's lowest point on the canvas
	def lowest_point
		ys = [@y1, @y2, @y3, @y4]
		xs = [@x1, @x2, @x3, @x4]
		return [xs[ys.index(ys.max)], ys.max]
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
end
