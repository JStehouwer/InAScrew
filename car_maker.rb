require 'gosu'
require 'pry'
require_relative 'circle.rb'
require_relative 'quad.rb'
require_relative 'button.rb'
require_relative 'car.rb'

class CarMaker < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Tutorial Game"
    @clickedX1 = -1
    @clickedY1 = -1
    @clickedX2 = -1
    @clickedY2 = -1
    @clickedX3 = -1
    @clickedY3 = -1
    @clickedX4 = -1
    @clickedY4 = -1

    @circleY1 = -1
    @circleY2 = -1
    @circleX1 = -1
    @circleX2 = -1

    #@quadArray = Array.new
    #@circleArray = Array.new
    @shapeArray = Array.new

    @mode = 0

    @saved = false

    @myCircle = Circle.new(100,100, 200, 200)
    @myQuad = Quad.new(10,10,10,20,20,20,20,10)
    @quadButton = Button.new(0,0,"media/quadButton1.png", "media/quadButton2.png", 200, 50)
    @circleButton = Button.new(200, 0, "media/circleButton1.png", "media/circleButton2.png", 200, 50)
    @saveButton = Button.new(400,0, "media/saveButton1.png","media/saveButton1.png",150,50)

  end

  def update

    if button_down?(Gosu::MsLeft)

      if (@quadButton.isClicked(mouse_x, mouse_y))
        @saveButton.onRelease
        @saved = false
        @quadButton.onClick
        @circleButton.onRelease
        @mode = 1

      elsif (@circleButton.isClicked(mouse_x, mouse_y))
        @saveButton.onRelease
        @saved = false
        @circleButton.onClick
        @quadButton.onRelease
        @mode = 2

      elsif (@saveButton.isClicked(mouse_x, mouse_y))
        @saveButton.onClick
        @circleButton.onRelease
        @quadButton.onRelease
        if not @saved
          @saved = true
          load
        end

    elsif @mode == 1
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
            @shapeArray.push(Quad.new(@clickedX1,@clickedY1,@clickedX2,@clickedY2,@clickedX3,@clickedY3,@clickedX4, @clickedY4)) 
            @clickedX1 = -1       
            @clickedY1 = -1
            @clickedX2 = -1
            @clickedY2 = -1
            @clickedX3 = -1
            @clickedY3 = -1
          end
      end
    elsif @mode == 2
        puts("X1: ", @clickedX1, "Y1: ", @clickedY1, "X2 ", @clickedX2, "Y2 ", @clickedY2)
        if @circleX1 == -1  #have not reset
          if dist(@circleX2, @circleY2, mouse_x, mouse_y) > 10
            @circleX1 = mouse_x #set to where we are
            @circleY1 = mouse_y
            @circleX2 = -1
            @circleY2 = -1
          end
        elsif @circleX2 == -1 #have not reset
          if dist(@circleX1, @circleY1, mouse_x, mouse_y) > 10
          @circleX2 = mouse_x
          @circleY2 = mouse_y
          #@myCircle = Circle.new(@circleX1, @circleY1, @circleX2, @circleY2)
          @shapeArray.push(Circle.new(@circleX1, @circleY1, @circleX2, @circleY2)) 
          @circleX1 = -1       
          @circleY1 = -1
        end
    end
  end
  end

  def dist(spotX, spotY, spotX2, spotY2)
    puts('spotX', spotX, 'spotY', spotY, 'spotX2', spotX2, 'spotY2', spotY2)
     Math.sqrt( (spotX - spotX2)*(spotX - spotX2) + (spotY - spotY2)*(spotY - spotY2) )
  end

  def save
    open("dopestCarEva.txt", 'w') { |f|
      @shapeArray.each{|shape| f << shape.toString << "\n"}
    }
  end

  def load
    @shapeArray = Array.new
    puts "hi"
    f = File.open("dopestCarEva.txt", "r")
      puts "I am happy."
      f.each_line { |line|
      words = line.split
      numbers = Array.new
      words.each{|word| numbers.push(word.to_f)}
      print words[0]
      print words[1]
      if numbers[0] == 1
        @shapeArray.push(Quad.new(numbers[1],numbers[2],numbers[3],numbers[4],numbers[5],numbers[6],numbers[7],numbers[8]))
      elsif numbers[0] == 2
        @shapeArray.push(Circle.new(numbers[1],numbers[2],numbers[1]+numbers[3],numbers[2]))
      end
    }
    f.close
  end

  def draw
    @myQuad.draw
    #@circleArray.each{|circle| circle.draw}
    #@quadArray.each{|quad| quad.draw}
    @shapeArray.each{|shape| shape.draw}
    @quadButton.draw
    @circleButton.draw
    @saveButton.draw
    draw_quad(mouse_x, mouse_y, Gosu::Color.argb(0xffffffff), mouse_x+5, mouse_y+5, Gosu::Color.argb(0xffffffff), mouse_x+5, mouse_y, 0xffffffff, mouse_x, mouse_y+5, Gosu::Color.argb(0xffffffff), z=500, mode = :default)
  end
end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

end
CarMaker.new.show
