defmodule Connect4Engine.Rules do
  alias __MODULE__

  defstruct state: :initialized

  def new(), do: %Rules{}
end
