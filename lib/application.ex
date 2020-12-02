defmodule Advent2020.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: AdventFinch}
    ]

    opts = [strategy: :one_for_one, name: Advent2020.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
