import Config

config :e_commers_ca, timezone: "America/Bogota"

config :e_commers_ca,
  http_port: 8083,
  enable_server: true,
  secret_name: "",
  version: "0.0.1",
  in_test: false,
  custom_metrics_prefix_name: "e_commers_ca_local"

config :logger,
  level: :debug

# tracer
config :opentelemetry,
  span_processor: :batch,
  traces_exporter: {:otel_exporter_stdout, []}

config :e_commers_ca, ECommersCa.Infrastructure.Adapters.Repository.Repo,
  database: "e_commers_app_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10,
  telemetry_prefix: [:elixir, :repo]

config :e_commers_ca,
  product_behaviour: ECommersCa.Infrastructure.Adapters.Repository.Product.ProductDataRepository,
  client_behaviour: ECommersCa.Infrastructure.Adapters.Repository.Client.ClientDataRepository,
  generic_uuid_behaviour: ECommersCa.Infrastructure.Adapters.Generic.UuidData


