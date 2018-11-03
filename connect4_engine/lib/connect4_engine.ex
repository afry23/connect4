defmodule Connect4Engine do
  use Application

  def start(_start_type, _start_args) do
    children = [
      {Registry, keys: :unique, name: Connect4Engine.GameRegistry}
    ]

    opts = [strategy: :one_for_one, name: Connect4Engine.GameSupervisor]
    Supervisor.start_link(children, opts)
  end
end
