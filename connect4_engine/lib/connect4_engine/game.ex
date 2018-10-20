defmodule Connect4Engine.Game do
  alias Connect4Engine.{Game, Coordinate, ConnectFourChecker}

  @enforce_keys [:coordinates]
  defstruct coordinates: nil, winner: nil

  def new() do
    coordinates =
      for row <- 1..6 do
        for col <- 1..7 do
          Coordinate.new(row, col)
        end
      end

    %Game{coordinates: coordinates}
  end

  def add(game, col, player) do
    coordinate =
      game.coordinates
      |> Enum.reverse()
      |> List.flatten()
      |> Enum.find(fn coordinate -> coordinate.col == col && coordinate.marked_by == nil end)
    update_coordinate(game, coordinate.row, col, player)
    assign_winner_if_four_in_a_row(game, player)
  end

  def mark(game, row, col, player) do
    game
    |> update_coordinate(row, col, player)
    |> assign_winner_if_four_in_a_row(player)
  end

  defp update_coordinate(game, row, col, player) do
    new_coordinates =
      game.coordinates
      |> List.flatten()
      |> Enum.map(&mark_coordinate(&1, row, col, player))
      |> Enum.chunk_every(Enum.count(game.coordinates) + 1)
    %Game{coordinates: new_coordinates}
  end

  defp mark_coordinate(coordinate, row, col, player) do
    case {coordinate.row, coordinate.col} == {row, col} do
      true  -> %Coordinate{coordinate | marked_by: player}
      false -> coordinate
    end
  end

  defp assign_winner_if_four_in_a_row(game, player) do
    case ConnectFourChecker.four_in_a_row?(game.coordinates) do
      true  -> %{game | winner: player}
      false -> game
    end
  end
end
