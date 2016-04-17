class MasterMind
  def initialize
    @master_code = set_master_code
    @current_turn = 1
  	@number_of_turns = 12
  	@current_guess = []
		@scantron = []
  	@current_correct_positions = 0
  	@current_correct_colors = 0
  end
  
  def set_master_code
    code = []
  	4.times do
      code << (rand(9) + 1)
  	end
    code
  end

  def get_guess
  	valid_guess = false
		print "\n#{" " if @current_turn < 10}#{@current_turn.to_s}: "
  	until valid_guess
  	  guess = gets.chomp.split("").map { |val| val.to_i }
  	  if (guess.all? { |val| (1..9).include? val }) && guess.length == 4
  	    valid_guess = true
  	  else
  	    puts "Invalid code, please try again."
				print "\n#{" " if @current_turn < 10}#{@current_turn.to_s}: "
  	  end
  	end
  	@current_guess = guess
  end

	def run_scantron
		correct_positions = 0
		correct_numbers = 0
		
		frequencies = Hash.new(0)
		@master_code.each do |x|
			frequencies[x] += 1
		end
		
		4.times do |x|
			if @master_code[x] == @current_guess[x]
				correct_positions += 1
				frequencies[@current_guess[x]] -= 1
			end
		end
		
		4.times do |x|
			if (@master_code[x] != @current_guess[x]) && (@master_code.include? @current_guess[x]) && (frequencies[@current_guess[x]] > 0)
				correct_numbers += 1
				frequencies[@current_guess[x]] -= 1
			end
		end
		
		@scantron = []
		correct_positions.times { @scantron << "X" }
		correct_numbers.times { @scantron << "?" }
		while @scantron.length < 4 do
			@scantron << "-"
		end
  end
  
	def scan_guess
		run_scantron
  	if player_wins?
  	  puts "You cracked the code!"
  	else
			print "     " + @scantron[0..1].join("") + "\n     " + @scantron[2..3].join("")
    end
  end
  
  def player_wins?
  	@current_guess == @master_code
  end
  
  def play
  	until player_wins? || (@current_turn > @number_of_turns)
  	  get_guess
			scan_guess
  	  @current_turn += 1
    end
  end
  
end

game = MasterMind.new

game.play

