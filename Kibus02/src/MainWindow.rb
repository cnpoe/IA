require 'gosu'
require './Grass.rb'
require './Tree.rb'
require './House.rb'
require './Character.rb'
require './Ruby2.rb'

class MainWindow < Gosu::Window
	def initialize
		super LENGTH, WIDTH, false
		self.caption = "El mundo de Kibus"
		#@pointer = Gosu::Image.new self, "../images/pointer.png", true
		@speed = 0.1
		@grass = Grass.new self
		@trees = Tree.new self
		@pHouse = -1
		@house = House.new @pHouse, self
		@trees.setPositions
		#@trees.mapaDos
		@character = Character.new @pHouse, self
		@ruby = Ruby.new -1, self
		@positions = @trees.getPositions
		@x = @y = 0
		@flag = false
		@game_music = Gosu::Song.new '../sound/vodka.ogg'
		resetVisiteds
	end  
	def resetVisiteds
		@visited = Array.new 300, 0
		@positions.each do |position|
			@visited[position] = '1000000'.to_i
		end
	end
	def needs_cursor?
		true
	end
	def update
		if self.button_down? Gosu::KbF4
			@speed < 0.2 ? @speed += 0.01 : @speed = 0.2
		end
		if self.button_down? Gosu::KbF5
			@speed > 0.01 ? @speed -= 0.01 : @speed = 0.1
		end
		if self.button_down? Gosu::KbF1
			resetVisiteds
			@trees.mapaUno
			@positions = @trees.getPositions
		end
		if self.button_down? Gosu::KbF2
			resetVisiteds
			@trees.mapaDos
			@positions = @trees.getPositions
		end
		if self.button_down? Gosu::KbF3
			resetVisiteds
			@trees.mapaTres
			@positions = @trees.getPositions
		end
		if self.button_down? Gosu::MsLeft
			@x = mouse_x.to_i
			@y = mouse_y.to_i
			resetVisiteds
			if @x >= 0 and @y >= 0 and @x < LENGTH and @y < WIDTH
				@tmpX = (@x - @x % 32) / 32
				@tmpY = (@y - @y % 32) / 32
				posTmp = @tmpX + 20 * @tmpY
				if not @positions.include? posTmp
					@character = Character.new posTmp, self
					@currentPosition = posTmp
				end
			end
		end
		if self.button_down? Gosu::MsRight
			@x = mouse_x.to_i
			@y = mouse_y.to_i
			resetVisiteds
			if @x >= 0 and @y >= 0 and @x < LENGTH and @y < WIDTH
				@tmpX = (@x - @x % 32) / 32
				@tmpY = (@y - @y % 32) / 32
				posTmp = @tmpX + 20 * @tmpY
				if not @positions.include? posTmp
					@pHouse = posTmp
					@house = House.new @pHouse, self
					@x1 = @pHouse % 20
					@y1 = @pHouse / 20
				end
			end
		end
		if self.button_down? Gosu::KbEscape
			@flag = true
			@game_music.play true
		end
		
		if @flag
			posAnterior = @currentPosition
			@x0 = @currentPosition % 20
			@y0 = @currentPosition / 20
			puts "posicion actual: #{@currentPosition}"
			dx = @x1 - @x0
			dy = @y1 - @y0
			if dx.abs > dy.abs
				m = dy.to_f / dx.to_f
				b = @y0 - m * @x0
				if dx < 0
					dx = -1
				else
					dx = 1
				end
				if @x0 != @x1
					@x0 += dx
					@y0 = (m * @x0 + b).round
					@currentPosition = accommodate @currentPosition
					@visited[@currentPosition] +=1
					@character = Character.new @currentPosition, self
				end
			elsif dy != 0
				m = dx.to_f / dy.to_f
				b = @x0 - m * @y0
				if dy < 0
					dy = -1
				else
					dy = 1
				end
				if
					@y0 += dy
					@x0 = (m * @y0 + b).round
					@currentPosition = accommodate @currentPosition
					@visited[@currentPosition]+=1
					@character = Character.new @currentPosition, self
				end
			end
			@ruby = Ruby.new posAnterior, self
		end
		
		if @currentPosition == @pHouse and @flag
			puts "posicion actual: #{@currentPosition}"
			puts "*********************"
			printVisiteds
			resetVisiteds
			@flag = false
			@game_music.pause
		end
		#p @visited
	end
	
	def randomPosition prev
		puts prev % 20
		mov = [-21, -1, 19, -20, 20, -19, 1, 21]
		if prev % 20 == 19
			np = mov[rand 0..4]
		elsif prev % 20 == 0
			np = mov[rand 3..7]
		else
			np = mov[rand 8]
		end
		puts np
		return np
	end
	
	def stuck pos
		mov = Array.new
		if pos % 20 == 19
			mov = [-21, -1, 19, -20, 20]
		elsif pos % 20 == 0
			mov = [-20, 20, -19, 1, 21]
		else
			mov = [-21, -1, 19, -20, 20, -19, 1, 21]
		end
		mov.each do |m|
			if not (@positions.include? pos + m or pos + m < 0 or pos + m >= 300 or @ruby.getPosition == pos + m or @visited[pos + m] > 0)
				return false
			end
		end
		return true
	end
	
	def printVisiteds
		for i in 0..299
			if i % 20 == 0
				print "\n"
			end
			print "#{@visited[i]} "
		end
	end

	def minNeighborsVisited pos
		mov = Array.new
		
		puts "Entregando el vecino menor: "
		
		if pos % 20 == 19
			mov = [-21, -1, 19, -20, 20]
		elsif pos % 20 == 0
			mov = [-20, 20, -19, 1, 21]
		else
			mov = [-21, -1, 19, -20, 20, -19, 1, 21]
		end
		
		min = '1000000'.to_i
		npos = pos
		
		mov2 = Array.new
		
		mov.each do |m|
			if min > @visited[pos + m].to_i and pos + m >= 0 and pos + m < 300
				min = @visited[pos + m].to_i
				mov2.clear
				mov2.push m
			elsif min == @visited[pos + m].to_i and pos + m >= 0 and pos + m < 300
				mov2.push m
			end
		end
		
		m = rand 0..mov2.size - 1
		m = mov2[m]
		
		return pos + m
	end

	def accommodate prev
		tmp = @x0 + @y0 * 20
		if stuck prev
			puts "estoy atorado :p"
			return minNeighborsVisited prev
			return @ruby.getPosition
		end
		if @positions.include? tmp or @ruby.getPosition == tmp
			np = randomPosition prev
			while @positions.include? prev + np or prev + np < 0 or prev + np >= 300 or @ruby.getPosition == prev + np or @visited[prev + np] > 0
				if stuck prev
					puts "Regresando vecino menor"
					return minNeighborsVisited prev
				end
				np = randomPosition prev
			end
			puts "posicion del ruby: #{@ruby.getPosition}\t posicion calculada: #{prev + np}"
			return prev + np
		else
			return tmp
		end
	end
	
	def draw
		@grass.draw
		@trees.draw
		@house.draw
		@ruby.draw
		@character.draw
		sleep @speed
	end
end
