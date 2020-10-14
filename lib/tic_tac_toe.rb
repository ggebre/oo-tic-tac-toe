require 'pry'
class TicTacToe
    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5 ], [6, 7, 8], [0, 3, 6],
                        [1,4,7], [2, 5, 8], [0,4,8], [2,4,6]]
    attr_accessor :board
    def initialize 
        @board = Array.new(9, " ")
    end

    def display_board 
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index (input)
        # convert input to integer and subtract 1 from the result
       input.to_i - 1
    end

    def move(position, token="X")
        # change the value at the position of the board to given token
        board[position] = token
    end
    def position_taken?(position)
        # check if the value of the board at the given position is
        # X or O 
        board[position] == "X" || board[position] == "O"
    end

    def valid_move? (position)
        # position should be between 0 and 8
        # the position is taken or not 
        result = true
        result = nil if position_taken?(position)
        result = nil if position < 0 || position > 8
        result
    end
    def turn_count 
        # select the positions which have been taken and count
        board.select {|position|  position == "X" || position == "O" }.length
    end
    def current_player
        # turn count is even it is 'X' turn
        turn_count.even? ? "X" : "O"
    end

    def turn 
        # accespts user input
        # use input_to_index to change input to integer
        # check if the input is a valid move
        # if valid move, call current_player and update board
        # display board

        puts "Enter a number between 1 - 9: "
        user_input = gets.chomp
        position = input_to_index(user_input)
        if valid_move? (position)
            token = current_player
            move(position, token)
        else
            turn
        end

        display_board
    end

    def won?
        # check if the board has "X" or "O" in either of the WIN_COMBINATIONS
        result =  nil
        WIN_COMBINATIONS.detect do |win_combination| 
            result = win_combination if win_combination.all? {|position| board[position] == "X"} 
            result = win_combination if win_combination.all? {|position| board[position] == "O"}
        end
        result
    end

    def full?
        turn_count == board.length
    end

    def draw?
        # draw if board is full but no one won the game
        return true if full? && !won?
        return false if won?
        return false if !full? || !won?
    end

    def over?
        return true if draw?
        return true if won?
        return false if !full? || !won?
    end

    def winner 
        # find the winner by getting the first index of win_combination from won?

        won? ? board[won?[0]] : nil
        # token = nil
        # token = board[won?[0]] if won?
        # token
    end

    def play 
        # puts "Enter a number between 1 - 9: "
        message = ""
        if over?
            message = "Congratulations #{winner}!" if won?
            message = "Cat's Game!" if draw?
            puts message
        else
            turn 
            play
        end
        
    end

end