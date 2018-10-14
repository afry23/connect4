defmodule Connect4Engine.Display do
  alias IO.ANSI

  def display(game) do
    print_coordinates(game.coordinates)
    print_winner(game)
  end

  defp print_coordinates(coordinates) do
    IO.write("\n")

    Enum.each(coordinates, fn row_coordinate ->
      print_row(row_coordinate)
    end)
  end

  defp print_row(coordinates) do
    coordinates
    |> Enum.map_join(" |  ", &square_in_ansi_format(&1))
    |> IO.puts()
  end

  defp square_in_ansi_format(coordinate) do
    [color_of_coordinate(coordinate), "O"]
    |> ANSI.format(true)
    |> IO.chardata_to_string()
  end

  defp color_of_coordinate(coordinate) do
    case coordinate.marked_by do
      nil    -> ANSI.normal()
      player -> player.color
    end
  end

  defp print_winner(game) do
    IO.write("\n")

    status =
      case game.winner do
        nil    -> " 🙁  No winner (yet) "
        player -> " ⭐️  WINNER! #{player.name} wins!"
      end

    IO.puts([ANSI.inverse(), status, ANSI.reset()])

    IO.write("\n")
  end
end
