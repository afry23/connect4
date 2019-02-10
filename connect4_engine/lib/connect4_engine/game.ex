defmodule Connect4Engine.Game do
  alias Connect4Engine.{Game, Coordinate, ConnectFourChecker, Player}

  @enforce_keys [:coordinates]
  defstruct coordinates: nil, winner: nil
  @players [:red, :yellow]

  def new() do
    coordinates =
      for row <- 1..6 do
        for col <- 1..7 do
          Coordinate.new(row, col)
        end
      end
    %Game{coordinates: coordinates}
  end

  def add(game, col, color) do
    coordinate =
      game.coordinates
      |> Enum.reverse()
      |> List.flatten()
      |> Enum.find(fn coordinate -> coordinate.col == col && coordinate.marked_by == nil end)
    update_coordinate(game, coordinate.row, col, color)
    assign_winner_if_four_in_a_row(game, color)
  end

  defp update_coordinate(game, row, col, color) do
    new_coordinates =
      game.coordinates
      |> List.flatten()
      |> Enum.map(&mark_coordinate(&1, row, col, color))
      |> Enum.chunk_every(Enum.count(game.coordinates) + 1)
    %Game{coordinates: new_coordinates}
  end

  defp mark_coordinate(coordinate, row, col, color) do
    case {coordinate.row, coordinate.col} == {row, col} do
      true  -> %Coordinate{coordinate | marked_by: color}
      false -> coordinate
    end
  end

  defp assign_winner_if_four_in_a_row(game, color) do
    case ConnectFourChecker.four_in_a_row?(game.coordinates) do
      true  -> %{game | winner: color}
      false -> game
    end
  end
end
