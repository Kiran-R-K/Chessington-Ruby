module Chessington
  module Engine
    ##
    # An abstract base class from which all pieces inherit.
    module Piece
      attr_reader :player, :moved

      def initialize(player)
        @player = player
        @moved = false
      end

      ##
      #  Get all squares that the piece is allowed to move to.
      def available_moves(board)
        raise "Not implemented"
      end


      ##
      # Move this piece to the given square on the board.
      def move_to(board, new_square)
        current_square = board.find_piece(self)
        board.move_piece(current_square, new_square)
        @moved = true
      end
    end

    ##
    # A class representing a chess pawn.
    class Pawn
      include Piece

      def available_moves(board)
        @moves = []
        @current_square = board.find_piece(self)
        @player_colour = self.player.colour
        new_row = one_row_forward
        possible_move = Square.at(new_row, @current_square.column)
        pawn_not_blocked = board.get_piece(possible_move).nil?
        @moves << possible_move if pawn_not_blocked

        if pawn_not_blocked && !@moved
          new_row = two_rows_forward
          possible_move = Square.at(new_row, @current_square.column)
          pawn_not_blocked = board.get_piece(possible_move).nil?
          @moves << possible_move if pawn_not_blocked
        end


        find_diagonal_squares(@current_square)
        find_available_diagonal_moves(board)

        return @moves

      end

      def one_row_forward
        @player_colour == :black ? @current_square.row - 1 : @current_square.row + 1
      end

      def two_rows_forward
        @player_colour == :black ? @current_square.row - 2 : @current_square.row + 2
      end


        def find_diagonal_squares(square)
          @top_right = Square.at(square.row + 1, square.column - 1)
          @top_left = Square.at(square.row - 1, square.column - 1)
          @bottom_right = Square.at(square.row + 1, square.column + 1)
          @bottom_left = Square.at(square.row - 1, square.column + 1)
        end

      def find_available_diagonal_moves(board)
        opponent_colour = self.player.opponent
        diagonal_squares = [ @top_right, @top_left, @bottom_right, @bottom_left ]
        diagonal_squares.each do |square|
          piece = board.get_piece(square)
          if piece != nil && piece != "off board" && piece.player.colour == opponent_colour.colour
            @moves << square
          end
        end
      end




    end

    ##
    # A class representing a chess knight.
    class Knight
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess bishop.
    class Bishop
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess rook.
    class Rook
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess queen.
    class Queen
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess king.
    class King
      include Piece

      def available_moves(board)
        []
      end
    end
  end
end
