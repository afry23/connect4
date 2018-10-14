defmodule Connect4Engine.Player do
  alias __MODULE__

  @enforce_keys [:name, :color]
  defstruct [:name, :color]

  def new(name, :red) do
    %Player{name: name, color: :red}
  end

  def new(name, :yellow) do
    %Player{name: name, color: :yellow}
  end

  def new(_name, _color), do: {:error, :invalide_color}
end
