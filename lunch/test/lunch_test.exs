defmodule LunchTest do
  use ExUnit.Case
  doctest Lunch

  test "greets the world" do
    assert Lunch.hello() == :world
  end
end
