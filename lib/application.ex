defmodule Advent.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: AdventFinch}
    ]

    opts = [strategy: :one_for_one, name: Advent.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
