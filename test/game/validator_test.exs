defmodule ValidatorTest do
  use ExUnit.Case

  alias Game.Validator

  describe "validate/2" do
    test "returns an invalid error paired with the reason when the user enters a non numerical string" do
      user_input = "not a number"

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Validator.validate(board, user_input) == {:invalid, :non_numerical}
    end

    test "returns an invalid error paired with the reason when the user enters an input out of the boards bounds" do
      user_input = "10"

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Validator.validate(board, user_input) == {:invalid, :out_of_bounds}
    end

    test "returns an invalid error paired with the reason when the user enters an input where the space is taken" do
      user_input = "3"

      board = %{
        1 => :empty, 2 => :empty, 3 => "X",
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Validator.validate(board, user_input) == {:invalid, :space_taken}
    end

    test "returns the users input when it is a valid numerical string" do
      user_input = "4"

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Validator.validate(board, user_input) == {:ok, 4}
    end

    test "returns the users input when it is a valid number" do
      user_input = 5

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Validator.validate(board, user_input) == {:ok, 5}
    end
  end
end
