require_relative "test_helper"
require "Chessington/engine"

class TestPieces < Minitest::Test
  class TestPawn < Minitest::Test
    include Chessington::Engine

    def test_white_pawns_can_move_up_one_square

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(2, 4))
    end

    def test_black_pawns_can_move_down_one_square

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(5, 4))
    end

    def test_white_pawn_can_move_up_two_squares_if_not_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(3, 4))
    end

    def test_black_pawn_can_move_down_two_squares_if_not_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(4, 4))
    end

    def test_white_pawn_cannot_move_up_two_squares_if_already_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      starting_square = Square.at(1, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(2, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))

    end

    def test_black_pawn_cannot_move_down_two_squares_if_already_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      starting_square = Square.at(6, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(5, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))

    end

    def test_white_pawn_cannot_move_if_piece_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_black_pawn_cannot_move_if_piece_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_white_pawn_cannot_move_two_squares_if_piece_two_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)

    end

    def test_black_pawn_cannot_move_two_squares_if_piece_two_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(4, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)

    end

    def test_white_pawn_cannot_move_two_squares_if_piece_one_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(2, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))

    end

    def test_black_pawn_cannot_move_two_squares_if_piece_one_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))

    end

    def test_white_pawn_cannot_move_at_top_of_board

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(7, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_black_pawn_cannot_move_at_bottom_of_board

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(0, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_white_pawns_can_capture_diagonally

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::BLACK)
      enemy1_square = Square.at(4, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::BLACK)
      enemy2_square = Square.at(4, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)

    end

    def test_black_pawns_can_capture_diagonally

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::WHITE)
      enemy1_square = Square.at(2, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::WHITE)
      enemy2_square = Square.at(2, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)

    end

    def test_white_pawns_cannot_move_diagonally_except_to_capture

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(4, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 3))
      refute_includes(moves, Square.at(4, 5))

    end

    def test_black_pawns_cannot_move_diagonally_except_to_capture

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(2, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 3))
      refute_includes(moves, Square.at(2, 5))
    end
  end

  class TestRook < Minitest::Test
    include Chessington::Engine

    # The rook can move to as many non-occupied squares left, right, up, or down.
    #   Additionally, the rook cannot jump over other pieces.
    # the rook can take pieces somehow ?

    # def test_white_rooks_can_move_up_one_square
    #
    #   # Arrange
    #   board = Board.empty
    #   rook = Rook.new(Player::WHITE)
    #   square = Square.at(1, 4)
    #   board.set_piece(square, rook)
    #
    #   # Act
    #   moves = rook.available_moves(board)
    #
    #   # Assert
    #   assert_includes(moves, Square.at(2, 4))
    # end
    #
    # def test_black_pawns_can_move_down_one_square
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   square = Square.at(6, 4)
    #   board.set_piece(square, pawn)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_includes(moves, Square.at(5, 4))
    # end
    #
    # def test_white_pawn_can_move_up_two_squares_if_not_moved
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   square = Square.at(1, 4)
    #   board.set_piece(square, pawn)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_includes(moves, Square.at(3, 4))
    # end
    #
    # def test_black_pawn_can_move_down_two_squares_if_not_moved
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   square = Square.at(6, 4)
    #   board.set_piece(square, pawn)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_includes(moves, Square.at(4, 4))
    # end
    #
    # def test_white_pawn_cannot_move_up_two_squares_if_already_moved
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   starting_square = Square.at(1, 4)
    #   board.set_piece(starting_square, pawn)
    #
    #   intermediate_square = Square.at(2, 4)
    #   pawn.move_to(board, intermediate_square)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, Square.at(4, 4))
    #
    # end
    #
    # def test_black_pawn_cannot_move_down_two_squares_if_already_moved
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   starting_square = Square.at(6, 4)
    #   board.set_piece(starting_square, pawn)
    #
    #   intermediate_square = Square.at(5, 4)
    #   pawn.move_to(board, intermediate_square)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, Square.at(3, 4))
    #
    # end
    #
    # def test_white_pawn_cannot_move_if_piece_in_front
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   pawn_square = Square.at(4, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   obstructing_square = Square.at(5, 4)
    #   obstruction = Pawn.new(Player::BLACK)
    #   board.set_piece(obstructing_square, obstruction)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_equal(moves.length, 0)
    #
    # end
    #
    # def test_black_pawn_cannot_move_if_piece_in_front
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   pawn_square = Square.at(4, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   obstructing_square = Square.at(3, 4)
    #   obstruction = Pawn.new(Player::WHITE)
    #   board.set_piece(obstructing_square, obstruction)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_equal(moves.length, 0)
    #
    # end
    #
    # def test_white_pawn_cannot_move_two_squares_if_piece_two_in_front
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   pawn_square = Square.at(1, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   obstructing_square = Square.at(3, 4)
    #   obstruction = Pawn.new(Player::BLACK)
    #   board.set_piece(obstructing_square, obstruction)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, obstructing_square)
    #
    # end
    #
    # def test_black_pawn_cannot_move_two_squares_if_piece_two_in_front
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   pawn_square = Square.at(6, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   obstructing_square = Square.at(4, 4)
    #   obstruction = Pawn.new(Player::WHITE)
    #   board.set_piece(obstructing_square, obstruction)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, obstructing_square)
    #
    # end
    #
    # def test_white_pawn_cannot_move_two_squares_if_piece_one_in_front
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   pawn_square = Square.at(1, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   obstructing_square = Square.at(2, 4)
    #   obstruction = Pawn.new(Player::BLACK)
    #   board.set_piece(obstructing_square, obstruction)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, Square.at(3, 4))
    #
    # end
    #
    # def test_black_pawn_cannot_move_two_squares_if_piece_one_in_front
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   pawn_square = Square.at(6, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   obstructing_square = Square.at(5, 4)
    #   obstruction = Pawn.new(Player::WHITE)
    #   board.set_piece(obstructing_square, obstruction)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, Square.at(4, 4))
    #
    # end
    #
    # def test_white_pawn_cannot_move_at_top_of_board
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   square = Square.at(7, 4)
    #   board.set_piece(square, pawn)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_equal(moves.length, 0)
    #
    # end
    #
    # def test_black_pawn_cannot_move_at_bottom_of_board
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   square = Square.at(0, 4)
    #   board.set_piece(square, pawn)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_equal(moves.length, 0)
    #
    # end
    #
    # def test_white_pawns_can_capture_diagonally
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   pawn_square = Square.at(3, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   enemy1 = Pawn.new(Player::BLACK)
    #   enemy1_square = Square.at(4, 5)
    #   board.set_piece(enemy1_square, enemy1)
    #
    #   enemy2 = Pawn.new(Player::BLACK)
    #   enemy2_square = Square.at(4, 3)
    #   board.set_piece(enemy2_square, enemy2)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_includes(moves, enemy1_square)
    #   assert_includes(moves, enemy2_square)
    #
    # end
    #
    # def test_black_pawns_can_capture_diagonally
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   pawn_square = Square.at(3, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   enemy1 = Pawn.new(Player::WHITE)
    #   enemy1_square = Square.at(2, 5)
    #   board.set_piece(enemy1_square, enemy1)
    #
    #   enemy2 = Pawn.new(Player::WHITE)
    #   enemy2_square = Square.at(2, 3)
    #   board.set_piece(enemy2_square, enemy2)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   assert_includes(moves, enemy1_square)
    #   assert_includes(moves, enemy2_square)
    #
    # end
    #
    # def test_white_pawns_cannot_move_diagonally_except_to_capture
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::WHITE)
    #   pawn_square = Square.at(3, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   friendly = Pawn.new(Player::WHITE)
    #   friendly_square = Square.at(4, 5)
    #   board.set_piece(friendly_square, friendly)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, Square.at(4, 3))
    #   refute_includes(moves, Square.at(4, 5))
    #
    # end
    #
    # def test_black_pawns_cannot_move_diagonally_except_to_capture
    #
    #   # Arrange
    #   board = Board.empty
    #   pawn = Pawn.new(Player::BLACK)
    #   pawn_square = Square.at(3, 4)
    #   board.set_piece(pawn_square, pawn)
    #
    #   friendly = Pawn.new(Player::BLACK)
    #   friendly_square = Square.at(2, 5)
    #   board.set_piece(friendly_square, friendly)
    #
    #   # Act
    #   moves = pawn.available_moves(board)
    #
    #   # Assert
    #   refute_includes(moves, Square.at(2, 3))
    #   refute_includes(moves, Square.at(2, 5))
    # end
  end
end
