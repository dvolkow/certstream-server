defmodule Certstream do
  @moduledoc """
  Certstream is a service for watching CT servers, parsing newly discovered certificates,
  and broadcasting updates to connected websocket clients.
  """
  use Application

  def start(_type, _args) do
    children = [
      # Web services
      Certstream.WebsocketServer,

      # Clickhouse Queue:
      {
        Certstream.ChQueue,
        database: Application.fetch_env!(:certstream, :database),
        table: Application.fetch_env!(:certstream, :table),
        port: Application.fetch_env!(:certstream, :ch_port),
        host: Application.fetch_env!(:certstream, :ch_host),
        user: Application.fetch_env!(:certstream, :ch_user),
        password: Application.fetch_env!(:certstream, :ch_password),
        pool_size: Application.fetch_env!(:certstream, :pool_size),
        rate: Application.fetch_env!(:certstream, :rate),
        batch_size: Application.fetch_env!(:certstream, :batch_size)
      },

      # Agents
      Certstream.ClientManager,
      Certstream.CertifcateBuffer,

      # Watchers
      {DynamicSupervisor, name: WatcherSupervisor, strategy: :one_for_one}
    ]

    supervisor_info = Supervisor.start_link(children, strategy: :one_for_one)

    Certstream.CTWatcher.start_and_link_watchers(name: WatcherSupervisor)

    supervisor_info
  end
end
