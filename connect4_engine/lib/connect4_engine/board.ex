defmodule Connect4Engine.Board do
  alias Connect4Engine.{Coordinate, Board}

  @enforce_keys [:reds, :yellows]
  defstruct [:reds, :yellows]

  def new(), do: %Board{reds: MapSet.new(), yellows: MapSet.new()}

  def add(%Board{} = board, :red, %Coordinate{} = coordinate) do
    update_in(board.reds, &MapSet.put(&1, coordinate))
    win_check(board)
  end

  def add(%Board{} = board, :yellow, %Coordinate{} = coordinate) do
    update_in(board.yellows, &MapSet.put(&1, coordinate))
    win_check(board)
  end

  defp win_check(_board) do
    false
  end

end
