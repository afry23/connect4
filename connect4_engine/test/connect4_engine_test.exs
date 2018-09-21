defmodule Connect4EngineTest do
  use ExUnit.Case
  doctest Connect4Engine

  test "greets the world" do
    assert Connect4Engine.hello() == :world
  end
end
