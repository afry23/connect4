defmodule Connect4Engine.Player do
  alias __MODULE__

  @enforce_keys [:name, :color]
  defstruct [:name, :color]

  def new(name, color) do
    %Player{name: name, color: color}
  end
end
