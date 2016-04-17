class GameBoard
  attr_accessor :board, :player_1, :player_2, :active_player
  
  def initialize
  	@board = {
	  top_left: 1,
	  top_mid: 2,
	  top_right: 3,
	  mid_left: 4,
	  mid_mid: 5,
	  mid_right: 6,
	  bot_left: 7,
	  bot_mid: 8,
	  bot_right: 9 }
	@winning_combinations = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
	@player_1 = Player.new("Player 1", "X")
	@player_2 = Player.new("Player 2", "O")
	@active_player = @player_2
  end
  
  def change_active_player
  	@active_player == @player_1 ? @active_player = @player_2 : @active_player = @player_1
  end
  
  def draw
  	i = 1
	board.each do |key, val|
	  print "|" + val.to_s
	  print "|\n" if i % 3 == 0
	  i += 1
	end
  end
  
  def locate(number)
  	board.detect { |key, val| val == number }.shift
  end
  
  def legal_move?(number)
  	if (player_1.moves.include? number) || (player_2.moves.include? number)
  		false
  	else
  		true
  	end
  end
  
  def mark(number)
  	if legal_move?(number)
  	  board[locate(number)] = active_player.marker
  	  active_player.moves << number
  	end
  end
  
  def get_move
  	valid_input = false
  	print "#{active_player.name}'s turn. Please enter a number to make your move:"
  	until valid_input
  	  move = gets.chomp.to_i
  	  if ((1..9).include? move) && (legal_move?(move))
  	  	valid_input = true
  	  else
  	  	puts "Invalid move, try again:"
  	  end
  	end
  	move
  end
  
  def cats_game?
  	board.all? { |key, value| value.is_a? String }
  end
  
  def winner?
  	winner = false
  	@winning_combinations.each do |combo|
  	  if (combo.all? { |value| active_player.moves.include? value })
        winner = true
      end
    end
    winner
  end
  def game_over?
  	winner? || cats_game?
  end
  
end

class Player
  attr_reader :name, :marker
  attr_accessor :moves
  
  def initialize(name, marker)
  	@name = name
  	@marker = marker
  	@moves = []
  end

end

def play_tic_tac_toe
  game = GameBoard.new
  game.draw
  until game.game_over?
    game.change_active_player
    game.mark(game.get_move)
    game.draw
  end
  if game.winner?
    puts "Congratulations! #{game.active_player.name} wins!"
  else
    puts "I'm so sorry, it's a Cat's Game!"
  end
end

play_tic_tac_toe
