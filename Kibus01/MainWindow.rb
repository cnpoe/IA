require 'gosu'
require './Grass.rb'
require './Tree.rb'
require './House.rb'
require './Character.rb'

class MainWindow < Gosu::Window
	def initialize
		super 640, 516, false
		self.caption = "El mundo de Kibus"
		@grass = Grass.new self
		@trees = Tree.new self
		@trees.setPositions
		@pHouse = rand 300
		@house = House.new @pHouse, self
		@positions = @trees.getPositions
		while true
			if not @positions.include? @pHouse
				@house = House.new @pHouse, self
				break
			else
				@pHouse = rand 300
			end
			p @pHouse
		end
		@character = Character.new @pHouse, self
		@stack = Array.new
		@stack.push @pHouse
		@flag = false
	end  
	def needs_cursor?
		true
	end
	def update
		#puts "(" + @character.getX.to_s + "," + @character.getY.to_s + ")"
		@actual = @character.getX + @character.getY * 20
		#puts @actual
		if self.button_down? Gosu::KbA
			@newX = @character.getX - 1
			@newPosition = @actual - 1
			if @newX >= 0 and not @positions.include? @newPosition 
				@character.moveLeft
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbD
			@newPosition = @actual + 1
			@newX = @character.getX + 1
			if @newX < 20 and not @positions.include? @newPosition
				@character.moveRight
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbW
			@newPosition = @actual - 20
			@newY = @character.getY - 1
			if @newY >= 0 and not @positions.include? @newPosition 
				@character.moveUp
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbX
			@newPosition = @actual + 20
			@newY = @character.getY + 1
			if @newY < 15 and not @positions.include? @newPosition
				@character.moveDown
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbQ
			@newPosition = @actual - 21
			@newX = @character.getX - 1
			@newY = @character.getY - 1
			if @newY >= 0 and @newX >= 0 and not @positions.include? @newPosition
				@character.moveLeftUp
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbE
			@newPosition = @actual - 19
			@newX = @character.getX + 1
			@newY = @character.getY - 1
			if @newY >= 0 and @newX < 20 and not @positions.include? @newPosition
				@character.moveRightUp
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbZ
			@newPosition = @actual + 19
			@newX = @character.getX - 1
			@newY = @character.getY + 1
			if @newY < 15 and @newX >= 0 and not @positions.include? @newPosition
				@character.moveLeftDown
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::KbC
			@newPosition = @actual + 21
			@newX = @character.getX + 1
			@newY = @character.getY + 1
			if @newY < 15 and @newX < 20 and not @positions.include? @newPosition
				@character.moveRightDown
				@stack.push @newPosition
			end
		end
		if self.button_down? Gosu::MsLeft
			@x = mouse_x.to_i
			@y = mouse_y.to_i
			puts "(" + @x.to_s + "," + @y.to_s + ")"
			if @x > 597 and @y > 480 and @x < 640 and @y < 516
				@flag = true
			end
			if @x >= 0 and @y >= 0 and @x < 640 and @y < 480
				@stack = @stack.clear
				@tmpX = (@x - @x % 32) / 32
				@tmpY = (@y - @y % 32) / 32
				puts "(" + @tmpX.to_s + "," + @tmpY.to_s + ")"
				@posTmp = @tmpX + 20 * @tmpY
				puts @posTmp
				if not @positions.include? @posTmp
					@pHouse = @posTmp
					@house = House.new @pHouse, self
					@character = Character.new @pHouse, self
				end
				@stack.push @pHouse
			end
		end
		if self.button_down? Gosu::KbEscape
			if not @flag
				@flag = true
			end
		end

		if @flag and not @stack.empty?
			@tmp = @stack.pop
			@actual = @character.getX + @character.getY * 20
			if @tmp == @actual - 21
				@character.moveLeftUp
			elsif @tmp == @actual - 20
				@character.moveUp
			elsif @tmp == @actual - 19
				@character.moveRightUp
			elsif @tmp == @actual - 1
				@character.moveLeft
			elsif @tmp == @actual + 1
				@character.moveRight
			elsif @tmp == @actual + 19
				@character.moveLeftDown
			elsif @tmp == @actual + 20
				@character.moveDown
			elsif @tmp == @actual + 21
				@character.moveRightDown
			end
		end
	end
  
	def draw
		@grass.draw
		@trees.draw
		@house.draw
		@character.draw
		sleep 0.1
	end
end
