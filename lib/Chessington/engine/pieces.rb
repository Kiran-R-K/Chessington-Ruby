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
        moves = []
        current_square = board.find_piece(self)
        if self.player.colour == :black
          new_row = current_square.row - 1
        else
          new_row = current_square.row + 1
        end
        move = Square.at(new_row, current_square.column)
        if board.get_piece(move) == nil
          moves << move
          if !@moved
            if self.player.colour == :black
              new_row = current_square.row - 2
            else
              new_row = current_square.row + 2
            end
            move = Square.at(new_row, current_square.column)
            if board.get_piece(move) == nil
              moves << move
            end
          end
        end

        return moves
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
