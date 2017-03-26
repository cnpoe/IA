class Tree
	def initialize window
		@image = Gosu::Image.new window, "tree.png", false
		@x = 0
		@y = 0
		@positions = Array.new
	end
	def setPositions
		@trees = DENSITY * 300
		@trees = @trees.to_i
		until @positions.size == @trees
			@positions.push rand 300
			@positions.uniq!
		end
		@positions.sort!
		p @positions
	end
	def draw
		@positions.each do |position|
			@x = position % 20 * 32
			@y = position / 20 * 32
			@image.draw @x, @y, 1
		end
	end
	def getPositions
		return @positions
	end
end