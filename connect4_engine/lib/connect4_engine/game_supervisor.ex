defmodule Coonect4Engine.GameSupervisor do
  use Supervisor
  alias Connect4Engine.GameServer

  def start_link(_options) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Supervisor.init([GameServer], strategy: :simple_onoe_for_one)
  end
end
