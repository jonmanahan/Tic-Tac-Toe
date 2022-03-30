defmodule ValidatorTest do
  use ExUnit.Case

  describe "validate/1" do
    test "checks that the user input is a non_numerical string" do
      user_input = "not a number"

      assert Validator.validate(user_input) == {:error, :non_numerical}
    end

    test "checks that the user input is a numerical string" do
      user_input = "4"

      assert Validator.validate(user_input) == {:ok, 4}
    end

    test "checks that the user input is a number instead of a numerical string" do
      user_input = 5

      assert Validator.validate(user_input) == {:ok, 5}
    end
  end
end
