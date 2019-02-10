defmodule Connect4Negine.GameTest do
  use ExUnit.Case, async: true

  test "add player one" do
    game = Connect4Engine.Game.new()
    assert game.player1 = nil
  end
end
