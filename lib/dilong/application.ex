defmodule Dilong.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Dilong.Repo,
      # Start the Telemetry supervisor
      DilongWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dilong.PubSub},
      # Start the Endpoint (http/https)
      DilongWeb.Endpoint
      # Start a worker by calling: Dilong.Worker.start_link(arg)
      # {Dilong.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dilong.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DilongWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
