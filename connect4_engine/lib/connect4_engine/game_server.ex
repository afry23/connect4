defmodule Connect4Engine.GameServer do
  use GenServer
  alias Connect4Engine.{Game, Rules, Player}

  def start_link(game_name) when is_binary(game_name), do:
    GenServer.start_link(__MODULE__, game_name, name: via_tuple(game_name))

  def init(game_name) do
    {:ok, %{player1: nil, player2: nil, rules: %Rules{}, game: Game.new()}}
  end

  def via_tuple(game_name), do:
    {:via, Registry, {Connect4Engine.GameRegistry, game_name}}

  def add_player(game_server, player_name) when is_binary(player_name) do
    GenServer.call(game_server, {:add_player, player_name})
  end

  def add_tile(game_server, player, col), do:
    GenServer.call(game_server, {:add_tile, player, col})

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

  def handle_call({:add_tile, player, col}, _from, state) do
    new_game = Game.add(state.game, col, player)
    new_state = put_in(state.game, new_game)
    reply_success(new_state, :ok)
  end

  defp update_player2(state_data, name), do:
    put_in(state_data.player2, Player.new(name, :yellow))

  defp update_rules(state_data, rules), do: %{state_data | rules: rules}

  defp reply_success(state_data, reply), do: {:reply, reply, state_data}
end
