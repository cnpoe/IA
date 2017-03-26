class Grass
	def initialize window
		@image = Gosu::Image.new window, "grass.png", false
		@apply = Gosu::Image.new window, "apply.png", false
		@x = 0
		@y = 0
	end
	def draw
		for i in 0..19
			for j in 0..14
				@x = i * 32
				@y = j * 32
				@image.draw @x, @y, 1
			end
		end
		@apply.draw 597, 480, 1
	end
end