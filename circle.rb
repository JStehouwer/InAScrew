require 'gosu'

class Circle
  def initialize(x1, y1, x2, y2)
    @x1, @y1 = x1.round,y1.round #center of circle
    @radius = dist(x1, y1, x2, y2).round
    @circle = Gosu::Image.new("media/circle.png",:tileable=>true)
  end

  def draw(xCor, yCor)
    @circle.draw(@x1-@radius + xCor,@y1-@radius + yCor,1,@radius*0.006,@radius*0.006) #drawing at center
  end

  def dist(spotX, spotY, spotX2, spotY2)
     Math.sqrt( (spotX - spotX2)*(spotX - spotX2) + (spotY - spotY2)*(spotY - spotY2) )
  end

  def toString
     "2 " + @x1.to_s + " " + @y1.to_s + " " + @radius.to_s
  end

  def contains(x2, y2)
    dist(@x1,@y1,x2,y2)<@radius
  end

	def lowest_point
		[@x1,@y1 + @radius]
	end

	def lowest_point_y
		lowest_point[1]
	end

	# Returns the lowest y value for a given x
	def lowest_for_x(x)
		points = lowest_points
		return points[x]
	end

	def leftmost_x
		(@x1-@radius).round
	end

	def rightmost_x
		(@x1+@radius).round
	end

	# Returns a hash of the lower half of the circle
	def lowest_points
		vals = {}
		(@x1-@radius..@x1+@radius).each do |a|
			vals[a] = Math.sqrt(@radius*@radius-(@x1-a)*(@x1-a)).round
		end
		return vals
	end

end
