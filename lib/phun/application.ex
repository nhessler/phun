defmodule Phun.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhunWeb.Telemetry,
      # Start the Ecto repository
      Phun.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phun.PubSub},
      # Start Finch
      {Finch, name: Phun.Finch},
      # Start the Endpoint (http/https)
      PhunWeb.Endpoint
      # Start a worker by calling: Phun.Worker.start_link(arg)
      # {Phun.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phun.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhunWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
