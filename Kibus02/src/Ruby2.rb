class Ruby
	def initialize pos, window
		@x = pos % 20 * 32
		@y = pos / 20 * 32
		@image = Gosu::Image.new window, "../img/ruby.png", false
	end
	def draw
		@image.draw @x, @y, 1
	end
	def getPosition
		return 20 * @y / 32 + @x / 32
	end
end