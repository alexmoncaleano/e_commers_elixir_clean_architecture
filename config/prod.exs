import Config

config :e_commers_ca, timezone: "America/Bogota"

config :e_commers_ca,
  http_port: 8083,
  enable_server: true,
  secret_name: "",
  version: "0.0.1",
  in_test: false,
  custom_metrics_prefix_name: "e_commers_ca"

config :logger,
  level: :warning

# tracer
config :opentelemetry,
  span_processor: :batch,
  traces_exporter: :otlp

config :opentelemetry_exporter,
  otlp_protocol: :http_protobuf,
  otlp_endpoint: "http://localhost:4318"

config :e_commers_ca, ECommersCa.Infrastructure.Adapters.Repository.Repo,
  database: "",
  username: "",
  password: "",
  hostname: "",
  pool_size: 10,
  telemetry_prefix: [:elixir, :repo]
