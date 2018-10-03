defmodule Connect4Engine.Coordinate do
  alias __MODULE__
  @board_rows 1..6
  @board_cols 1..7

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  def new(row, col) when row in(@board_rows) and col in(@board_cols), do:
    {:ok, %Coordinate{row: row, col: col}}

  def new(_row, _col), do: {:error, :invalid_coordinate}
end
