class Character
	def initialize pos, window
		@x = pos % 20 * 32
		@y = pos / 20 * 32
		@image = Gosu::Image.new window, "../img/character.png", false
	end
	def draw
		@image.draw @x, @y, 1
	end
	def moveRight
		@x = @x + 32
	end
	def moveLeft
		@x = @x - 32
	end
	def moveUp
		@y = @y - 32
	end
	def moveDown
		@y = @y + 32
	end
	def moveLeftUp
		@x = @x - 32
		@y = @y - 32
	end
	def moveLeftDown
		@x = @x - 32
		@y = @y + 32
	end
	def moveRightUp
		@x = @x + 32
		@y = @y - 32
	end
	def moveRightDown
		@x = @x + 32
		@y = @y + 32
	end
	def getX
		return @x / 32
	end
	def getY
		return @y / 32
	end
end
