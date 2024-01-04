defmodule LunchDatastoreTest do
  use ExUnit.Case
  doctest LunchDatastore

  test "greets the world" do
    assert LunchDatastore.hello() == :world
  end
end
