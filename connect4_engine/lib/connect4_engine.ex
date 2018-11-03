defmodule Connect4Engine do
  use Application

  def start(_start_type, _start_args) do
    children = [
      {Registry, keys: :unique, name: Connect4Engine.GameRegistry}
    ]
  end
end
