defmodule Connect4Engine.ConnectFourChecker do

  def four_in_a_row?(coordinates) do
    possible_winning_sequenzes(coordinates)
    |> sequenzes_with_at_least_one_marked()
    |> Enum.map(&four_coordinates_marked_by_same_player?(&1))
    |> Enum.any?()
  end

  def possible_winning_sequenzes(coordinates) do
    coordinates ++
    transpose(coordinates) ++
    [left_diagonal_squares(coordinates), right_diagonal_squares(coordinates)]
  end

  def four_coordinates_marked_by_same_player?(coordinates) do
    first_coordinate = Enum.at(coordinates, 0)
    Enum.take(coordinates, 4)
    |> Enum.all?(fn c ->
      c.marked_by == first_coordinate.marked_by
    end)
  end

  def transpose(coordinates) do
    coordinates
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def sequenzes_with_at_least_one_marked(coordinates) do
    Enum.reject(coordinates, fn sequence ->
      Enum.reject(sequence, &is_nil(&1.marked_by)) |> Enum.empty?()
    end)
  end

  def left_diagonal_squares(coordinates) do
    coordinates
    |> List.flatten()
    |> Enum.take_every(Enum.count(coordinates) + 1)
  end

  def right_diagonal_squares(coordinates) do
    coordinates
    |> rotate_90_degrees()
    |> left_diagonal_squares()
  end

  def rotate_90_degrees(coordinates) do
    coordinates
    |> transpose()
    |> Enum.reverse()
  end
end
