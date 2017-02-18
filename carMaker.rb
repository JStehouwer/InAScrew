require 'gosu'
require 'pry'

require_relative 'quad.rb'
require_relative 'circle.rb'

class CarMaker < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Tutorial Game"
    @rectangles = Array.new
    @clickedX1 = -1
    @clickedY1 = -1
    @clickedX2 = -1
    @clickedY2 = -1
    @clickedX3 = -1
    @clickedY3 = -1
    @clickedX4 = -1
    @clickedY4 = -1
    @myQuad = Quad.new(10,10,10,20,20,20,20,10)
  end

  def update
    # ...

    if button_down?(Gosu::MsLeft)
			puts("X1: ", @clickedX1, "Y1: ", @clickedY1, "X2 ", @clickedX2, "Y2 ", @clickedY2, "X3 " ,@clickedX3, "Y3 " , @clickedY3, "X4 ", @clickedX4, "Y4", @clickedY4)
			if @clickedX1 == -1  #have not reset
				if dist(@clickedX4, @clickedY4, mouse_x, mouse_y) > 10
					@clickedX1 = mouse_x #set to where we are
					@clickedY1 = mouse_y
					@clickedX4 = -1;
					@clickedY4 = -1;
			end

    elsif @clickedX2 == -1 #have not reset x2
			if dist(@clickedX1, @clickedY1, mouse_x, mouse_y) > 10
				@clickedX2 = mouse_x
				@clickedY2 = mouse_y
		end

    elsif @clickedX3 == -1 #have not reset
			if dist(@clickedX2, @clickedY2, mouse_x, mouse_y) > 10
				@clickedX3 = mouse_x
				@clickedY3 = mouse_y
		end
    
		elsif @clickedX4 == -1 #have not reset
			if dist(@clickedX3, @clickedY3, mouse_x, mouse_y) > 10
				@clickedX4 = mouse_x
				@clickedY4 = mouse_y
        @myQuad = Quad.new(@clickedX1,@clickedY1,@clickedX2,@clickedY2,@clickedX3,@clickedY3,@clickedX4, @clickedY4) 
				@clickedX1 = -1		    
				@clickedY1 = -1
    		@clickedX2 = -1
    		@clickedY2 = -1
    		@clickedX3 = -1
    		@clickedY3 = -1
    	
			end
    end
  end     
 end

	def dist(spotX, spotY, spotX2, spotY2)
		 Math.sqrt( (spotX - spotX2)*(spotX - spotX2) + (spotY - spotY2)*(spotY - spotY2) )
	end

  def draw
    # ...
    @myQuad.draw
    
    draw_quad(mouse_x, mouse_y, Gosu::Color.argb(0xffffffff), mouse_x+5, mouse_y+5, Gosu::Color.argb(0xffffffff), mouse_x+5, mouse_y, 0xffffffff, mouse_x, mouse_y+5, Gosu::Color.argb(0xffffffff), z=1, mode = :default)
  end
end

CarMaker.new.show
