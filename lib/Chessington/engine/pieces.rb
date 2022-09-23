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

        one_move_forward = Square.at(one_row_forward, @current_square.column)

        if can_move(one_move_forward, board)
          @moves << one_move_forward
          if !@moved
            two_moves_forward = Square.at(two_rows_forward, @current_square.column)
            if can_move(two_moves_forward, board)
              @moves << two_moves_forward
            end
          end

        end

        find_diagonal_squares(@current_square)
        available_diagonal_moves = find_available_diagonal_moves(board)

        @moves.concat(available_diagonal_moves)

        @moves

      end

      def can_move(possible_move, board)
        board.get_piece(possible_move).nil?
      end


      def one_row_forward
        @player_colour == :black ? @current_square.row - 1 : @current_square.row + 1
      end

      def two_rows_forward
        @player_colour == :black ? @current_square.row - 2 : @current_square.row + 2
      end


        def find_diagonal_squares(square)
          @diagonal_squares = [
            Square.at(square.row + 1, square.column - 1),
            Square.at(square.row - 1, square.column - 1),
            Square.at(square.row + 1, square.column + 1),
            Square.at(square.row - 1, square.column + 1),
            ]
        end

      def find_available_diagonal_moves(board)
        @diagonal_squares.select! do |square|
          is_opponents_piece(board.get_piece(square))
        end
        @diagonal_squares
      end

      def is_opponents_piece(piece)
        opponent_colour = self.player.opponent
        piece != nil && piece != false && piece.player.colour == opponent_colour.colour
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
