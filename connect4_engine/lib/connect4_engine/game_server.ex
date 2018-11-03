defmodule Connect4Engine.GameServer do
  use GenServer
  alias Connect4Engine.{Game, Rules, Player}

  def start_link(player_name) when is_binary(player_name), do:
    GenServer.start_link(__MODULE__, player_name, [])

  def init(player_name) do
    player1 = Player.new(player_name, :red)
    {:ok, %{player1: player1, player2: nil, rules: %Rules{}, game: Game.new()}}
  end

  def add_player(game_server, player_name) when is_binary(player_name) do
    GenServer.call(game_server, {:add_player, player_name})
  end

  def handle_call({:add_player, player_name}, _from, state_data) do
    with {:ok, rules} <- Rules.check(state_data.rules, :add_player)
    do
      state_data
      |> update_player2(player_name)
      |> update_rules(rules)
      |> reply_success(:ok)
    else
      :error -> {:reply, :error, state_data}
    end
  end

  defp update_player2(state_data, name), do:
    put_in(state_data.player2, Player.new(name, :yellow))

  defp update_rules(state_data, rules), do: %{state_data | rules: rules}

  defp reply_success(state_data, reply), do: {:reply, reply, state_data}
end
