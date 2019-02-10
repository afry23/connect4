defmodule Connect4Engine.GameServerTest do
  use ExUnit.Case, async: true

  setup do
    game = start_supervised(Connect4Engine.GameServer)
    %{game: game}
  end

  test "add player", %{game: game} do
    Connect4Engine.GameServer.add_player(game, "Foo Bar")
  end

end
