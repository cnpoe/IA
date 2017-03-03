class House
	def initialize pos, window
		@x = pos % 20 * 32
		@y = pos / 20 * 32
		@image = Gosu::Image.new window, "../img/house.png", false
	end
	def draw
		@image.draw @x, @y, 1
	end
end
