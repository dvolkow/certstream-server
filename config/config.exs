import Config

config :certstream,
  # Defaults to "Certstream Server v{CURRENT_VERSION}"
  user_agent: :default,
  full_stream_url: "/full-stream",
  domains_only_url: "/domains-only",

  # Clickhouse Databases:
  database: "certs",
  table: "certs.domains",
  ch_host: "localhost",
  ch_port: 8123,
  # may be you need more, depends of load:
  pool_size: 1,
  # rate is time in milliseconds, 1_000 is 1 second:
  rate: 3_000,
  # min. collector queue length for insert to Clickhouse:
  batch_size: 10_000

config :logger,
  level: String.to_atom(System.get_env("LOG_LEVEL") || "info"),
  backends: [:console]

# Disable connection pooling for HTTP requests
config :hackney, use_default_pool: false
