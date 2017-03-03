class Tree
	def initialize window
		@image = Gosu::Image.new window, "../img/tree.png", false
		@x = 0
		@y = 0
		@positions = Array.new
	end
	def setPositions
		#@positions =  [18,38,58,78,98,118,138,158,178,198,218,238,258,278,298]
		@trees = DENSITY * 300
		@trees = @trees.to_i
		until @positions.size == @trees
			@positions.push rand 300
			@positions.uniq!
		end
	end
	
	def mapaDos
		@positions.clear
		(2..297).each do |n|
			if n % 20 == 2 and n < 243
				@positions.push n
			elsif n % 20 == 17 and n > 40
				@positions.push n
			elsif n % 20 == 5 and n > 40
				@positions.push n
			elsif n % 20 == 14 and n < 260
				@positions.push n
			elsif n % 20 == 8 and n < 260 and
				@positions.push n
			elsif n % 20 == 11 and n > 40
				@positions.push n
			end
		end
	end
	
	def mapaUno
		@positions.clear
		(42..57).each do |n|
			@positions.push n
		end
		(42..260).each do |n|
			if n % 20 == 2 or n % 20 == 17
				@positions.push n
			elsif (n % 20 == 5 or n % 20 == 14) and n > 100 and n < 200
				@positions.push n
			elsif (n % 20 == 8 or n % 20 == 11) and n > 120 and n < 160
				@positions.push n
			end
			
		end
		(243..248).each do |n|
			@positions.push n
		end
		(251..257).each do |n|
			@positions.push n
		end
		(186..193).each do |n|
			@positions.push n
		end
		(108..111).each do |n|
			@positions.push n
		end
	end
	
	def mapaTres
		@positions = [10,30,29,49,69,70,71,91,111,110,109,108,128,148,149,150,151,152,172,192,191,190,189,188,187,207,227,228,229,230,231,232,233,253,273,272,271,270,269,268,267,266]
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
