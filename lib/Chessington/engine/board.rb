

require_relative "data"
require_relative "pieces"

module Chessington
  module Engine


    ##
    #  A representation of the chess board, and the pieces on it.
    class Board
      attr_accessor :current_player, :board

      BOARD_SIZE = 8
      def initialize(player, board_state)
        @current_player = player
        @board = board_state
      end

      def self.empty
        Board.new(Player::WHITE, create_empty_board)
      end

      def self.at_starting_position
        Board.new(Player::WHITE, create_starting_board)
      end

      def self.create_empty_board
        Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
      end

      def self.create_starting_board
        board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }

        board[1] = Array.new(BOARD_SIZE) { Pawn.new(Player::WHITE) }
        board[6] = Array.new(BOARD_SIZE) { Pawn.new(Player::BLACK) }

        piece_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        board[0] = piece_row.map { |piece| piece.new(Player::WHITE) }
        board[7] = piece_row.map { |piece| piece.new(Player::BLACK) }

        board
      end

      ##
      # Places the piece at the given position on the board.
      def set_piece(square, piece)
        @board[square.row][square.column] = piece
      end

      ##
      # Retrieves the piece from the given square of the board.
      def get_piece(square)
        if is_square_on_board(square)
          @board[square.row][square.column]
        else
          false
        end
      end

      def is_square_on_board(square)
        square.row.between?(0,7) && square.column.between?(0,7) ? true : false
      end

      ##
      #  Searches for the given piece on the board and returns its square
      def find_piece(piece_to_find)
        (0...BOARD_SIZE).each do |row|
          (0...BOARD_SIZE).each do |col|
            if @board[row][col] == (piece_to_find)
              return Square.at(row, col)
            end
          end
        end
        raise "The supplied piece is not on the board"
      end

      ##
      #  Moves the piece from the given starting square to the given destination square.
      def move_piece(from_square, to_square)
        moving_piece = get_piece(from_square)
        if !moving_piece.nil? && moving_piece.player == @current_player
          set_piece(to_square, moving_piece)
          set_piece(from_square, nil)
          @current_player = @current_player.opponent
        end
      end

      private_class_method :create_empty_board, :create_starting_board
    end
  end
end
