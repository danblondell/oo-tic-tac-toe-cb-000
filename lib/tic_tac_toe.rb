class TicTacToe
  def initialize(board = Array.new(9, " "))
    @board = board
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [0, 4, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [2, 4, 6],
    [3, 4, 5],
    [6, 7, 8]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    @board[index] != "X" && @board[index] != "O" && index.between?(0, 8)
  end

  def current_player
    current_player = turn_count.even? ? "X" : "O"
  end

  def turn_count
    counter = 0
    @board.each do |spot|
      if spot != " "
        counter += 1
      end
    end
    turn_count = counter
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip

    index = input_to_index(input)

    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    winning_combo = []

    WIN_COMBINATIONS.each do |combo|
      (combo.all? {|spot| @board[spot] == "X"}) || (combo.all? {|spot| @board[spot] == "O"}) ? winning_combo = combo : false
    end

    (winning_combo != []) ? winning_combo : false
  end

  def full?
    (@board.all? {|spot| spot == "X" || spot == "O"})
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if won?
      @board[won?.first] == "X" ? "X" : "O"
    end
  end

  def play
    turn until over?

    if draw?
      puts "Cat's Game!"
    elsif won?
      puts "Congratulations #{winner}!"
    end
  end

end
