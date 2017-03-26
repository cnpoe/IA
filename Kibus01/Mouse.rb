require "gosu"

class GameWindow < Gosu::Window
	
	def initialize
		super(640,480,false)
		self.caption = "Gosu Window"
		@pointer = Gosu::Image.new(self,"hand.gif",true) # we're loading a picture of the mouse
		@px = @py = 0
	end
	
	def update
		@px = mouse_x # this method returns the x coordinate of the mouse
		@py = mouse_y # this method returns the y coordinate of the mouse
	end
	
	def draw
		@pointer.draw(@px,@py,0) # we're drawing the mouse at the current position
	end
	
end

if __FILE__ == $0
	a = GameWindow.new
	a.show
end